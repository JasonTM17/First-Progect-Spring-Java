package vn.hoidanit.laptopshop.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Locale;
import java.util.Set;

import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.ServletContext;

@Service
public class UploadService {

    private static final Set<String> ALLOWED_IMAGE_TYPES = Set.of(
            "image/jpeg",
            "image/png",
            "image/webp",
            "image/gif"
    );
    private static final Set<String> ALLOWED_IMAGE_EXTENSIONS = Set.of("jpg", "jpeg", "png", "webp", "gif");
    private static final long MAX_IMAGE_SIZE_BYTES = 5L * 1024L * 1024L;

    private final ServletContext servletContext;

    public UploadService(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    public String handleSaveUploadFile(MultipartFile[] files, String targetFolder) {
        if (files == null || files.length == 0) {
            return "";
        }

        String finalName = "";
        Path directory = resolveUploadDirectory(targetFolder);

        try {
            Files.createDirectories(directory);
            for (MultipartFile file : files) {
                if (file == null || file.isEmpty()) {
                    continue;
                }
                String safeOriginalName = sanitizeFileName(file.getOriginalFilename());
                byte[] imageBytes = readValidatedImage(file, safeOriginalName);
                finalName = System.currentTimeMillis() + "-" + safeOriginalName;
                Path target = directory.resolve(finalName).normalize();
                if (!target.startsWith(directory)) {
                    throw new IllegalArgumentException("Tên file không hợp lệ");
                }
                Files.write(target, imageBytes);
            }
        } catch (IOException ex) {
            throw new IllegalStateException("Không thể lưu file tải lên", ex);
        }

        return finalName;
    }

    private Path resolveUploadDirectory(String targetFolder) {
        String rootPath = this.servletContext.getRealPath("/resources/images");
        Path root = rootPath == null
                ? Paths.get("src", "main", "webapp", "resources", "images").toAbsolutePath()
                : Paths.get(rootPath);
        return root.resolve(targetFolder).normalize();
    }

    private byte[] readValidatedImage(MultipartFile file, String safeOriginalName) throws IOException {
        String contentType = file.getContentType();
        String normalizedContentType = contentType == null ? "" : contentType.toLowerCase(Locale.ROOT);
        if (!ALLOWED_IMAGE_TYPES.contains(normalizedContentType)) {
            throw new IllegalArgumentException("Chỉ hỗ trợ file ảnh JPG, PNG, WEBP hoặc GIF");
        }
        if (file.getSize() > MAX_IMAGE_SIZE_BYTES) {
            throw new IllegalArgumentException("Ảnh tải lên không được vượt quá 5MB");
        }
        String extension = getExtension(safeOriginalName);
        if (!ALLOWED_IMAGE_EXTENSIONS.contains(extension)) {
            throw new IllegalArgumentException("Phan mo rong file anh khong hop le");
        }
        byte[] bytes = file.getBytes();
        if (!hasExpectedImageSignature(bytes, normalizedContentType, extension)) {
            throw new IllegalArgumentException("Noi dung file anh khong khop voi dinh dang tai len");
        }
        return bytes;
    }

    private String sanitizeFileName(String originalFilename) {
        String cleaned = StringUtils.cleanPath(originalFilename == null ? "upload" : originalFilename);
        if (cleaned.contains("..")) {
            throw new IllegalArgumentException("Tên file không hợp lệ");
        }
        cleaned = cleaned.replaceAll("[^A-Za-z0-9._-]", "_");
        return cleaned.isBlank() ? "upload" : cleaned;
    }

    private String getExtension(String filename) {
        int dotIndex = filename.lastIndexOf('.');
        if (dotIndex < 0 || dotIndex == filename.length() - 1) {
            return "";
        }
        return filename.substring(dotIndex + 1).toLowerCase(Locale.ROOT);
    }

    private boolean hasExpectedImageSignature(byte[] bytes, String contentType, String extension) {
        return switch (contentType) {
            case "image/jpeg" -> ("jpg".equals(extension) || "jpeg".equals(extension)) && isJpeg(bytes);
            case "image/png" -> "png".equals(extension) && isPng(bytes);
            case "image/webp" -> "webp".equals(extension) && isWebp(bytes);
            case "image/gif" -> "gif".equals(extension) && isGif(bytes);
            default -> false;
        };
    }

    private boolean isJpeg(byte[] bytes) {
        return bytes.length >= 3
                && (bytes[0] & 0xFF) == 0xFF
                && (bytes[1] & 0xFF) == 0xD8
                && (bytes[2] & 0xFF) == 0xFF;
    }

    private boolean isPng(byte[] bytes) {
        int[] signature = {0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A};
        if (bytes.length < signature.length) {
            return false;
        }
        for (int i = 0; i < signature.length; i++) {
            if ((bytes[i] & 0xFF) != signature[i]) {
                return false;
            }
        }
        return true;
    }

    private boolean isWebp(byte[] bytes) {
        return bytes.length >= 12
                && bytes[0] == 'R'
                && bytes[1] == 'I'
                && bytes[2] == 'F'
                && bytes[3] == 'F'
                && bytes[8] == 'W'
                && bytes[9] == 'E'
                && bytes[10] == 'B'
                && bytes[11] == 'P';
    }

    private boolean isGif(byte[] bytes) {
        return bytes.length >= 6
                && bytes[0] == 'G'
                && bytes[1] == 'I'
                && bytes[2] == 'F'
                && bytes[3] == '8'
                && (bytes[4] == '7' || bytes[4] == '9')
                && bytes[5] == 'a';
    }
}
