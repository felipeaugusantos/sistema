unit untGeraArquivoSaida;

interface

uses
  Classes, SysUtils, Variants,
  Controls, StdCtrls,
  Uni, DB, untFuncoesSimples,
  cxProgressBar, Forms,
  untFuncEditorRel, untGeraFR3,
  System.NetEncoding;

type
  TGeraArquivoSaida = class(TComponent)
    private
      FGeraGR3: TGeraFR3;

      FPasta: String;

      FintGerados,
      FintPulados,
      FintFalhas: Integer;

      FstlErros: TStringList;

      Function fGeraArquivo(Progress: TcxProgressBar): Boolean;

      Function fSanitizaNome(AstrNome: String): String;
      Function fRetEncoding: TEncoding;
      Function fGravaBOM: Boolean;
      Function fEhBase64: Boolean;
      Procedure pGravaArquivo(AstrCaminho, AstrConteudo: String);

    public

      constructor Create(AOwner: TComponent); Reintroduce;
      destructor Destroy; override;

      Function fGeraArquivos(strPasta: String): Boolean;

      Property intGerados: Integer Read FintGerados;
      Property intPulados: Integer Read FintPulados;
      Property intFalhas: Integer Read FintFalhas;

      Function fResumoErros: String;

    published

      Property objGeraGR3: TGeraFR3 Read FGeraGR3 Write FGeraGR3;

  end;

implementation

Uses
  untGravando;

Const
  ENC_UTF8     = 'UTF-8';
  ENC_UTF8_BOM = 'UTF-8 BOM';
  ENC_ANSI     = 'ANSI';
  ENC_UTF16    = 'UTF-16';
  ENC_BASE64   = 'Base64';

  CAMPO_NOME     = 'ARQUIVO_NOME';
  CAMPO_CONTEUDO = 'ARQUIVO_CONTEUDO';

  TAM_MAX_NOME = 200;

  NOMES_RESERVADOS = 'CON.PRN.AUX.NUL.' +
                     'COM1.COM2.COM3.COM4.COM5.COM6.COM7.COM8.COM9.' +
                     'LPT1.LPT2.LPT3.LPT4.LPT5.LPT6.LPT7.LPT8.LPT9';

constructor TGeraArquivoSaida.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FPasta      := '';
  FintGerados := 0;
  FintPulados := 0;
  FintFalhas  := 0;
  FstlErros   := TStringList.Create;
end;

destructor TGeraArquivoSaida.Destroy;
begin
  FreeAndNil(FstlErros);

  inherited;
end;

Function TGeraArquivoSaida.fResumoErros: String;
Begin
  Result := FstlErros.Text;
End;

Function TGeraArquivoSaida.fGeraArquivos(strPasta: String): Boolean;
Begin
  Try
    FPasta := strPasta;

    If (Not FPasta.IsEmpty) And (Not FPasta.EndsWith('\')) Then
      FPasta := Concat(FPasta, '\');

    FintGerados := 0;
    FintPulados := 0;
    FintFalhas  := 0;
    FstlErros.Clear;

    pCriarFormularios(TfrmGravando, frmGravando);
    Try
      frmGravando.lblGravando.Caption := 'Gerando arquivos...';
      frmGravando.fExecutarAcao := fGeraArquivo;
      frmGravando.ShowModal;

      Result := frmGravando.blnConfirma;
    Finally
      pFreeAndNil(frmGravando);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TGeraArquivoSaida.fGeraArquivos');
      Result := True;
    End;
  End;
End;

Function TGeraArquivoSaida.fGeraArquivo(Progress: TcxProgressBar): Boolean;
  Var
    strNome,
    strConteudo,
    strCaminho: String;
    blnSanitiza: Boolean;
Begin
  Result := False;

  Try
    If Length(FGeraGR3.qryDados) = 0 Then
    Begin
      pMensagemOk('Erro interno - Relatório não carregado!');
      Exit;
    End;

    If (Not Assigned(FGeraGR3.qryDados[0].FindField(CAMPO_NOME))) Or
       (Not Assigned(FGeraGR3.qryDados[0].FindField(CAMPO_CONTEUDO))) Then
    Begin
      pMensagemOk('O relatório deve retornar as colunas ' + CAMPO_NOME + ' e ' + CAMPO_CONTEUDO + '.');
      Exit;
    End;

    If FGeraGR3.qryDados[0].IsEmpty Then
    Begin
      pMensagemOk('Nenhum registro encontrado para gerar arquivos.');
      Exit;
    End;

    blnSanitiza := SameText(FGeraGR3.arrCadRel[0].FieldByName('REL_SANARQ').AsString, 'S');

    If Assigned(Progress) Then
    Begin
      Progress.Properties.Max := FGeraGR3.qryDados[0].RecordCount;
      Progress.Position       := 0;
    End;

    FGeraGR3.qryDados[0].First;

    While Not FGeraGR3.qryDados[0].Eof Do
    Begin
      strNome     := Trim(FGeraGR3.qryDados[0].FieldByName(CAMPO_NOME).AsString);
      strConteudo := FGeraGR3.qryDados[0].FieldByName(CAMPO_CONTEUDO).AsString;

      If blnSanitiza Then
        strNome := fSanitizaNome(strNome);

      If fEmptyStr(strNome) Then
        Inc(FintPulados)
      Else
      Begin
        pInformacao('Gerando arquivo: ' + strNome, Progress);
        Application.ProcessMessages;

        Try
          strCaminho := Concat(FPasta, strNome);
          pGravaArquivo(strCaminho, strConteudo);
          Inc(FintGerados);
        Except
          On E: Exception Do
          Begin
            Inc(FintFalhas);
            FstlErros.Add(strNome + ': ' + E.Message);
          End;
        End;
      End;

      If Assigned(Progress) Then
        Progress.Position := Progress.Position + 1;

      Application.ProcessMessages;

      FGeraGR3.qryDados[0].Next;
    End;

    Result := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TGeraArquivoSaida.fGeraArquivo');
      Result := True;
    End;
  End;
End;

Function TGeraArquivoSaida.fSanitizaNome(AstrNome: String): String;
  Var
    intContador: Integer;
    chrAtual: Char;
    strBase,
    strExt: String;
Begin
  Result := '';

  For intContador := 1 To Length(AstrNome) Do
  Begin
    chrAtual := AstrNome[intContador];

    If (chrAtual < #32) Or CharInSet(chrAtual, ['\', '/', ':', '*', '?', '"', '<', '>', '|']) Then
      Continue;

    Result := Result + chrAtual;
  End;

  Result := Trim(Result);

  If Result.IsEmpty Then
    Exit;

  strExt  := ExtractFileExt(Result);
  strBase := Copy(Result, 1, Length(Result) - Length(strExt));

  If Pos('.' + UpperCase(strBase) + '.', '.' + NOMES_RESERVADOS + '.') > 0 Then
    strBase := '_' + strBase;

  If Length(strBase) + Length(strExt) > TAM_MAX_NOME Then
    strBase := Copy(strBase, 1, TAM_MAX_NOME - Length(strExt));

  Result := strBase + strExt;
End;

Function TGeraArquivoSaida.fRetEncoding: TEncoding;
  Var
    strEnc: String;
Begin
  strEnc := Trim(FGeraGR3.arrCadRel[0].FieldByName('REL_ENCARQ').AsString);

  If SameText(strEnc, ENC_ANSI) Then
    Result := TEncoding.ANSI
  Else If SameText(strEnc, ENC_UTF16) Then
    Result := TEncoding.Unicode
  Else
    Result := TEncoding.UTF8;
End;

Function TGeraArquivoSaida.fGravaBOM: Boolean;
  Var
    strEnc: String;
Begin
  strEnc := Trim(FGeraGR3.arrCadRel[0].FieldByName('REL_ENCARQ').AsString);

  Result := SameText(strEnc, ENC_UTF8_BOM) Or SameText(strEnc, ENC_UTF16);
End;

Function TGeraArquivoSaida.fEhBase64: Boolean;
Begin
  Result := SameText(Trim(FGeraGR3.arrCadRel[0].FieldByName('REL_ENCARQ').AsString), ENC_BASE64);
End;

Procedure TGeraArquivoSaida.pGravaArquivo(AstrCaminho, AstrConteudo: String);
  Var
    encAtual: TEncoding;
    arrBytes,
    arrPreambulo: TBytes;
    fstArquivo: TFileStream;
Begin
  encAtual := nil;

  If fEhBase64 Then
    arrBytes := TNetEncoding.Base64.DecodeStringToBytes(AstrConteudo)
  Else
  Begin
    encAtual := fRetEncoding;
    arrBytes := encAtual.GetBytes(AstrConteudo);
  End;

  fstArquivo := TFileStream.Create(AstrCaminho, fmCreate);
  Try
    If Assigned(encAtual) And fGravaBOM Then
    Begin
      arrPreambulo := encAtual.GetPreamble;
      If Length(arrPreambulo) > 0 Then
        fstArquivo.WriteBuffer(arrPreambulo[0], Length(arrPreambulo));
    End;

    If Length(arrBytes) > 0 Then
      fstArquivo.WriteBuffer(arrBytes[0], Length(arrBytes));
  Finally
    FreeAndNil(fstArquivo);
  End;
End;

end.
