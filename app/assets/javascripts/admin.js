(function() {
    $(document).ready(function() {
        $(".selectpicker").length > 0 && $(".selectpicker").selectpicker();
        var addMessage, animateSidebarChart, data, events, inboxMessages, listItem, listSortable, makeMessageString, makeReplyString, someday, stats_shown, taskInput, today, tomorrow, uiChart1, uiChart2, uiChart3, uiPieChart, uiPieChart2;
        return makeMessageString = function(content) {
            return "<li class='right'><img src='placeholders/avatars/9.jpg' class='img-circle'><div class='message'>" + content + "</div></li>"
        }, makeReplyString = function(content) {
            return "<li><img src='placeholders/avatars/avatar.jpg' class='img-circle' width='26'><div class='message'>" + content + "</div></li>"
        }, addMessage = function(content, reply) {
            var message, messages;
            return null == reply && (reply = !1), messages = $(".chat-messages"), message = reply ? makeReplyString(content) : makeMessageString(content), messages.append(message), messages.scrollTop(messages.height())
        }, $(".messenger").length > 0 && (addMessage("Hey, how are you?"), setTimeout(function() {
            return addMessage("You like Sugoi Admin?")
        }, 5e3), setTimeout(function() {
            return addMessage("Quiet slick, isn't it? Have a look at widgets page and remember - there's a lot more coming soon!")
        }, 12e3), $("#message-input").keyup(function(e) {
            return 13 === e.keyCode ? (addMessage($(this).val(), !0), $(this).val("")) : void 0
        }), $("#chat-toggle").on("click", function() {
            return $(".messenger-body").toggleClass("open"), $("#chat-toggle .glyphicon").toggleClass("glyphicon-chevron-down glyphicon-chevron-up")
        })), $("#inbox-page").length > 0 && $.notify("You've got 4 new messages", "success", {
            autoHide: !0,
            autoHideDelay: 5e3,
            arrowShow: !1
        }), $("#dashboard-page").length > 0 && $.notify("Welcome back John", "info", {
            autoHide: !0,
            autoHideDelay: 5e3,
            arrowShow: !1
        }), $(".mosaicflow__item").each(function() {
            var path, pathConfig, s;
            return s = Snap(this.querySelector("svg")), path = s.select("path"), pathConfig = {
                from: path.attr("d"),
                to: this.getAttribute("data-path-hover")
            }, this.addEventListener("mouseenter", function() {
                return path.animate({
                    path: pathConfig.to
                }, 300, mina.easeinout)
            }), this.addEventListener("mouseleave", function() {
                return path.animate({
                    path: pathConfig.from
                }, 300, mina.easeinout)
            })
        }), $(".dropzone").length > 0 && (Dropzone.options.demoUpload = {
            paramName: "file",
            maxFilesize: 2,
            addRemoveLinks: !0
        }), listSortable = $(".list-editable"), listSortable.length > 0 && (listItem = $("#item-template").clone(), taskInput = $("#task-content"), $("#task-toggle").on("click", function(e) {
            return e.preventDefault(), taskInput.toggleClass("opacity-1"), taskInput.hasClass("opacity-1") ? taskInput.focus() : void 0
        }), taskInput.on("keyup", function(e) {
            var task, value;
            return 13 === e.keyCode ? (e.preventDefault(), value = $("#task-content").val(), task = listItem.clone(), $(".body", task).text(value), task.removeAttr("style"), task.removeAttr("id"), listSortable.prepend(task), $("#task-content").val(""), $("input", task).iCheck({
                checkboxClass: "icheckbox_flat-blue"
            })) : void 0
        }), listSortable.on("click", ".remove-box", function(e) {
            return e.preventDefault(), $(this).parent().remove()
        })), $("input.icheck").length > 0 && $("input.icheck").iCheck({
            checkboxClass: "icheckbox_flat-blue",
            radioClass: "iradio_flat-blue"
        })
    })
}).call(this);
