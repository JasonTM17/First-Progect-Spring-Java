package vn.hoidanit.laptopshop.controller.client;

import java.util.NoSuchElementException;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import vn.hoidanit.laptopshop.domain.dto.CartResponseDTO;

@RestControllerAdvice(assignableTypes = CartAPI.class)
public class ApiExceptionHandler {

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<CartResponseDTO> handleValidation(MethodArgumentNotValidException ex) {
        String message = ex.getBindingResult().getFieldError() == null
                ? "Dữ liệu không hợp lệ"
                : ex.getBindingResult().getFieldError().getDefaultMessage();
        return ResponseEntity.badRequest().body(new CartResponseDTO(0, message));
    }

    @ExceptionHandler({IllegalArgumentException.class, NoSuchElementException.class})
    public ResponseEntity<CartResponseDTO> handleBadRequest(Exception ex) {
        return ResponseEntity.badRequest().body(new CartResponseDTO(0, ex.getMessage()));
    }
}
