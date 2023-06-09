package com.myservice.dto;

import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString
public class LecSearch {
    private String keyword;
    private String search;
}
