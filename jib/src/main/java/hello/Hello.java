package hello;

import org.springframework.web.bind.annotation.*;

@RestController
public class Hello {
    @RequestMapping("/")
    public String index() {
        return "Hello, World!";
    }
}