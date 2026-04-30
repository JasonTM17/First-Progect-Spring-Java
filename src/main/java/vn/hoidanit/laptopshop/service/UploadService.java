package vn.hoidanit.laptopshop.service;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
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
                validateImage(file);
                String safeOriginalName = sanitizeFileName(file.getOriginalFilename());
                finalName = System.currentTimeMillis() + "-" + safeOriginalName;
                Path target = directory.resolve(finalName).normalize();
                if (!target.startsWith(directory)) {
                    throw new IllegalArgumentException("Tên file không hợp lệ");
                }
                try (InputStream inputStream = file.getInputStream()) {
                    Files.copy(inputStream, target, StandardCopyOption.REPLACE_EXISTING);
                }
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

    private void validateImage(MultipartFile file) {
        String contentType = file.getContentType();
        if (contentType == null || !ALLOWED_IMAGE_TYPES.contains(contentType.toLowerCase())) {
            throw new IllegalArgumentException("Chỉ hỗ trợ file ảnh JPG, PNG, WEBP hoặc GIF");
        }
    }

    private String sanitizeFileName(String originalFilename) {
        String cleaned = StringUtils.cleanPath(originalFilename == null ? "upload" : originalFilename);
        if (cleaned.contains("..")) {
            throw new IllegalArgumentException("Tên file không hợp lệ");
        }
        cleaned = cleaned.replaceAll("[^A-Za-z0-9._-]", "_");
        return cleaned.isBlank() ? "upload" : cleaned;
    }
}
