<%@ page contentType="text/html;charset=UTF-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="currentPage" value=""/>
<%@ include file="/WEB-INF/header.jsp" %>

<div class="card" style="text-align:center;padding:48px;max-width:500px;margin:auto">
    <div style="font-size:64px;margin-bottom:16px">❌</div>
    <h2 style="color:#dc3545;margin-bottom:12px">Đã xảy ra lỗi!</h2>
    <p style="color:#666;margin-bottom:8px">
        <c:choose>
            <c:when test="${not empty error}">${error}</c:when>
            <c:when test="${not empty exception}">${exception.message}</c:when>
            <c:otherwise>Lỗi không xác định. Vui lòng thử lại.</c:otherwise>
        </c:choose>
    </p>
    <div style="margin-top:24px;display:flex;gap:10px;justify-content:center">
        <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-primary">🏠 Trang chủ</a>
        <a href="javascript:history.back()" class="btn btn-secondary">↩ Quay lại</a>
    </div>
</div>

<%@ include file="/WEB-INF/footer.jsp" %>
