.class public Lcom/android/internal/widget/BackupQuestionUtils;
.super Ljava/lang/Object;
.source "BackupQuestionUtils.java"


# static fields
.field private static final BACKUP_QUESTION_FILE:Ljava/lang/String; = "/system/backup_question.key"

.field private static final QUESTION_EVER_SET:Ljava/lang/String; = "lockscreen.questioneverset"

.field private static final SELECTED_QUESTION:Ljava/lang/String; = "lockscreen.selectedquestion"

.field private static final TAG:Ljava/lang/String; = "SemcBackupQuestionUtils"

.field private static sBackupQuestionFilename:Ljava/lang/String;


# instance fields
.field private final mContentResolver:Landroid/content/ContentResolver;


# direct methods
.method public constructor <init>(Landroid/content/ContentResolver;)V
    .locals 2
    .parameter "contentResolver"

    .prologue
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/android/internal/widget/BackupQuestionUtils;->mContentResolver:Landroid/content/ContentResolver;

    sget-object v0, Lcom/android/internal/widget/BackupQuestionUtils;->sBackupQuestionFilename:Ljava/lang/String;

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Landroid/os/Environment;->getDataDirectory()Ljava/io/File;

    move-result-object v1

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/system/backup_question.key"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/android/internal/widget/BackupQuestionUtils;->sBackupQuestionFilename:Ljava/lang/String;

    :cond_0
    return-void
.end method

.method private getBoolean(Ljava/lang/String;)Z
    .locals 3
    .parameter "systemSettingKey"

    .prologue
    const/4 v0, 0x1

    const/4 v1, 0x0

    iget-object v2, p0, Lcom/android/internal/widget/BackupQuestionUtils;->mContentResolver:Landroid/content/ContentResolver;

    invoke-static {v2, p1, v1}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v2

    if-ne v0, v2, :cond_0

    :goto_0
    return v0

    :cond_0
    move v0, v1

    goto :goto_0
.end method

.method private getInt(Ljava/lang/String;I)I
    .locals 1
    .parameter "systemSettingKey"
    .parameter "def"

    .prologue
    iget-object v0, p0, Lcom/android/internal/widget/BackupQuestionUtils;->mContentResolver:Landroid/content/ContentResolver;

    invoke-static {v0, p1, p2}, Landroid/provider/Settings$System;->getInt(Landroid/content/ContentResolver;Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method private setBoolean(Ljava/lang/String;Z)V
    .locals 2
    .parameter "systemSettingKey"
    .parameter "enabled"

    .prologue
    iget-object v1, p0, Lcom/android/internal/widget/BackupQuestionUtils;->mContentResolver:Landroid/content/ContentResolver;

    if-eqz p2, :cond_0

    const/4 v0, 0x1

    :goto_0
    invoke-static {v1, p1, v0}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    return-void

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private setInt(Ljava/lang/String;I)V
    .locals 1
    .parameter "systemSettingKey"
    .parameter "value"

    .prologue
    iget-object v0, p0, Lcom/android/internal/widget/BackupQuestionUtils;->mContentResolver:Landroid/content/ContentResolver;

    invoke-static {v0, p1, p2}, Landroid/provider/Settings$System;->putInt(Landroid/content/ContentResolver;Ljava/lang/String;I)Z

    return-void
.end method

.method static stringToHash(Ljava/lang/String;)[B
    .locals 6
    .parameter "string"

    .prologue
    if-nez p0, :cond_0

    const/4 v0, 0x0

    :goto_0
    return-object v0

    :cond_0
    invoke-virtual {p0}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v1

    .local v1, lowerCaseString:Ljava/lang/String;
    invoke-virtual {v1}, Ljava/lang/String;->getBytes()[B

    move-result-object v4

    .local v4, res:[B
    :try_start_0
    const-string v5, "SHA-1"

    invoke-static {v5}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v2

    .local v2, md:Ljava/security/MessageDigest;
    invoke-virtual {v2, v4}, Ljava/security/MessageDigest;->digest([B)[B
    :try_end_0
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    .local v0, hash:[B
    goto :goto_0

    .end local v0           #hash:[B
    .end local v2           #md:Ljava/security/MessageDigest;
    :catch_0
    move-exception v3

    .local v3, nsa:Ljava/security/NoSuchAlgorithmException;
    move-object v0, v4

    goto :goto_0
.end method


# virtual methods
.method public checkAnswer(Ljava/lang/String;)Z
    .locals 8
    .parameter "enteredAnswer"

    .prologue
    const/4 v3, 0x0

    :try_start_0
    new-instance v4, Ljava/io/RandomAccessFile;

    sget-object v6, Lcom/android/internal/widget/BackupQuestionUtils;->sBackupQuestionFilename:Ljava/lang/String;

    const-string v7, "r"

    invoke-direct {v4, v6, v7}, Ljava/io/RandomAccessFile;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .local v4, raf:Ljava/io/RandomAccessFile;
    invoke-virtual {v4}, Ljava/io/RandomAccessFile;->length()J

    move-result-wide v6

    long-to-int v6, v6

    new-array v5, v6, [B

    .local v5, stored:[B
    const/4 v6, 0x0

    array-length v7, v5

    invoke-virtual {v4, v5, v6, v7}, Ljava/io/RandomAccessFile;->read([BII)I

    move-result v1

    .local v1, got:I
    invoke-virtual {v4}, Ljava/io/RandomAccessFile;->close()V

    if-gtz v1, :cond_0

    const-string v6, "SemcBackupQuestionUtils"

    const-string v7, "checkAnswer: got <= 0"

    invoke-static {v6, v7}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v3, 0x1

    .end local v1           #got:I
    .end local v4           #raf:Ljava/io/RandomAccessFile;
    .end local v5           #stored:[B
    :goto_0
    return v3

    .restart local v1       #got:I
    .restart local v4       #raf:Ljava/io/RandomAccessFile;
    .restart local v5       #stored:[B
    :cond_0
    invoke-static {p1}, Lcom/android/internal/widget/BackupQuestionUtils;->stringToHash(Ljava/lang/String;)[B

    move-result-object v6

    invoke-static {v5, v6}, Ljava/util/Arrays;->equals([B[B)Z
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    move-result v3

    .local v3, match:Z
    goto :goto_0

    .end local v1           #got:I
    .end local v3           #match:Z
    .end local v4           #raf:Ljava/io/RandomAccessFile;
    .end local v5           #stored:[B
    :catch_0
    move-exception v0

    .local v0, fnfe:Ljava/io/FileNotFoundException;
    const-string v6, "SemcBackupQuestionUtils"

    const-string v7, "checkAnswer: got FileNotFoundException"

    invoke-static {v6, v7}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0           #fnfe:Ljava/io/FileNotFoundException;
    :catch_1
    move-exception v2

    .local v2, ioe:Ljava/io/IOException;
    const-string v6, "SemcBackupQuestionUtils"

    const-string v7, "checkAnswer: got IOException"

    invoke-static {v6, v7}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public getSelectedQuestion(I)I
    .locals 1
    .parameter "defaultQuestionIndex"

    .prologue
    const-string v0, "lockscreen.selectedquestion"

    invoke-direct {p0, v0, p1}, Lcom/android/internal/widget/BackupQuestionUtils;->getInt(Ljava/lang/String;I)I

    move-result v0

    return v0
.end method

.method public isQuestionEverSet()Z
    .locals 1

    .prologue
    const-string v0, "lockscreen.questioneverset"

    invoke-direct {p0, v0}, Lcom/android/internal/widget/BackupQuestionUtils;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method

.method public saveQuestionAnswerPair(ILjava/lang/String;)V
    .locals 7
    .parameter "questionIndex"
    .parameter "answer"

    .prologue
    invoke-static {p2}, Lcom/android/internal/widget/BackupQuestionUtils;->stringToHash(Ljava/lang/String;)[B

    move-result-object v1

    .local v1, hash:[B
    :try_start_0
    new-instance v3, Ljava/io/RandomAccessFile;

    sget-object v4, Lcom/android/internal/widget/BackupQuestionUtils;->sBackupQuestionFilename:Ljava/lang/String;

    const-string v5, "rw"

    invoke-direct {v3, v4, v5}, Ljava/io/RandomAccessFile;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .local v3, raf:Ljava/io/RandomAccessFile;
    const-wide/16 v4, 0x0

    invoke-virtual {v3, v4, v5}, Ljava/io/RandomAccessFile;->setLength(J)V

    if-eqz p2, :cond_0

    const/4 v4, 0x0

    array-length v5, v1

    invoke-virtual {v3, v1, v4, v5}, Ljava/io/RandomAccessFile;->write([BII)V

    :cond_0
    invoke-virtual {v3}, Ljava/io/RandomAccessFile;->close()V

    const-string v4, "lockscreen.selectedquestion"

    invoke-direct {p0, v4, p1}, Lcom/android/internal/widget/BackupQuestionUtils;->setInt(Ljava/lang/String;I)V

    const-string v4, "lockscreen.questioneverset"

    const/4 v5, 0x1

    invoke-direct {p0, v4, v5}, Lcom/android/internal/widget/BackupQuestionUtils;->setBoolean(Ljava/lang/String;Z)V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    .end local v3           #raf:Ljava/io/RandomAccessFile;
    :goto_0
    return-void

    :catch_0
    move-exception v0

    .local v0, fnfe:Ljava/io/FileNotFoundException;
    const-string v4, "SemcBackupQuestionUtils"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "File not found. Unable to save backup question to "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    sget-object v6, Lcom/android/internal/widget/BackupQuestionUtils;->sBackupQuestionFilename:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0

    .end local v0           #fnfe:Ljava/io/FileNotFoundException;
    :catch_1
    move-exception v2

    .local v2, ioe:Ljava/io/IOException;
    const-string v4, "SemcBackupQuestionUtils"

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "IO Error. Unable to save backup question to "

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    sget-object v6, Lcom/android/internal/widget/BackupQuestionUtils;->sBackupQuestionFilename:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method public savedQuestionExists()Z
    .locals 7

    .prologue
    const/4 v4, 0x0

    :try_start_0
    new-instance v3, Ljava/io/RandomAccessFile;

    sget-object v5, Lcom/android/internal/widget/BackupQuestionUtils;->sBackupQuestionFilename:Ljava/lang/String;

    const-string v6, "r"

    invoke-direct {v3, v5, v6}, Ljava/io/RandomAccessFile;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .local v3, raf:Ljava/io/RandomAccessFile;
    invoke-virtual {v3}, Ljava/io/RandomAccessFile;->readByte()B

    invoke-virtual {v3}, Ljava/io/RandomAccessFile;->close()V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/EOFException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2

    const/4 v4, 0x1

    .end local v3           #raf:Ljava/io/RandomAccessFile;
    :goto_0
    return v4

    :catch_0
    move-exception v1

    .local v1, fnfe:Ljava/io/FileNotFoundException;
    goto :goto_0

    .end local v1           #fnfe:Ljava/io/FileNotFoundException;
    :catch_1
    move-exception v0

    .local v0, eofe:Ljava/io/EOFException;
    goto :goto_0

    .end local v0           #eofe:Ljava/io/EOFException;
    :catch_2
    move-exception v2

    .local v2, ioe:Ljava/io/IOException;
    goto :goto_0
.end method
