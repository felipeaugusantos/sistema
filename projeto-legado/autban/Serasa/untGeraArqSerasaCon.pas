unit untGeraArqSerasaCon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  FilenameEditFocus, strUtils, DirectoryEditFocus, Uni, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, 
  untFrameDirectoryEditFocus;

type
  TfrmGeraArqSerasaCon = class(TfrmPai)
    Label1: TLabel;
    pnlTopo: TPanel;
    Label2: TLabel;
    btnGerCon: TBitBtnLocked;
    edtArqRetorno: TFilenameEditFocus;
    fraArqSaida: TfraDirectoryEditFocus;
    procedure btnGerConClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }

    function fDuplicataPaga(    strNumDup,
                                strParcel,
                                strEspDoc,
                                strCodEmp,
                                strCodCli: String;
                                dtaDtaFin: TDate;
                            Var dtaDtaRec: TDate): Boolean;


    function fDuplicataExiste(    strNumDup,
                                  strParcel,
                                  strEspDoc,
                                  strCodEmp,
                                  strCodCli: String;
                              Var dtaDtaRec: TDate): Boolean;

  protected
    function fValidaArquivoRetorno(): Boolean;
  public
    function pGerarConciliacao: Boolean;
    { Public declarations }
  end;

var
  frmGeraArqSerasaCon: TfrmGeraArqSerasaCon;

implementation

uses untFuncoesSimples, DB;

{$R *.dfm}

{ TfrmGeraArqSerasaCon }

function TfrmGeraArqSerasaCon.fValidaArquivoRetorno: Boolean;
  Var
    mArquivo: TextFile;
    strNomeArquivo: String;
    strLinha: String;
    intAux: Integer;
begin

  Try
    strNomeArquivo := AnsiReplaceStr(edtArqRetorno.Text, '"', '');
    AssignFile(mArquivo, strNomeArquivo);
    Reset(mArquivo);

    Readln(mArquivo,strLinha);

    Result := (Copy(strLinha, 0, 2) = '00');

    If Not Result Then
    Begin
      CloseFile(mArquivo);
      Exit;
    End;

    While Not Eof(mArquivo) Do
    Begin
      If Not fEmptyStr(strLinha) Then
      Begin
        Readln(mArquivo, strLinha);

        If intAux <> 99 Then
          Result := TryStrToInt(LeftStr(strLinha, 2), intAux);

        If Not Result Then
        Begin
          CloseFile(mArquivo);
          Exit;
        End;
      End;
    End;

  Except
    Result := False;
  End;

  CloseFile(mArquivo);
end;

function TfrmGeraArqSerasaCon.fDuplicataPaga(    strNumDup,
                                                 strParcel,
                                                 strEspDoc,
                                                 strCodEmp,
                                                 strCodCli: String;
                                                 dtaDtaFin: TDate;
                                             Var dtaDtaRec: TDate): Boolean;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin
  Result := false;
  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT CTR_DTAREC FROM CADREC ';
    strSQL := strSQL + '  WHERE ';
    strSQL := strSQL + '    CTR_DTAREC <= :DTAREC  AND ';
    strSQL := strSQL + '    CTR_SEQBAI = 0         AND ';
    strSQL := strSQL + '    CTR_DTAREC IS NOT NULL AND ';
    strSQL := strSQL + '    CTR_NUMDUP = :NUMDUP   AND ';
    strSQL := strSQL + '    CTR_ESPDOC = :ESPDOC   AND ';
    strSQL := strSQL + '    CTR_PARCEL = :PARCEL   AND ';
    strSQL := strSQL + '    CTR_CODEMP = :CODEMP   AND ';
    strSQL := strSQL + '    CTR_CODCLI = :CODCLI       ';

    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      SQL.Text := strSQL;

      ParamByName('NUMDUP').AsString := strNumDup;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('PARCEL').AsString := strParcel;
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('DTAREC').AsDateTime := dtaDtaFin;

      Open;

      If Not IsEmpty Then
      Begin
        dtaDtaRec := FieldByName('CTR_DTAREC').AsDateTime;
        Result    := True;
      End Else
      Begin
        dtaDtaRec := 0;
        Result    := False;
      End;

    End;

    FreeAndNil(qryGen);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fDuplicataPaga]');
    End;
  End;

End;

procedure TfrmGeraArqSerasaCon.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtArqRetorno);
end;

function TfrmGeraArqSerasaCon.fDuplicataExiste(    strNumDup,
                                                   strParcel,
                                                   strEspDoc,
                                                   strCodEmp,
                                                   strCodCli: String;
                                               Var dtaDtaRec: TDate): Boolean;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin
  Result := false;
  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT CTR_DTAREC FROM CADREC ';
    strSQL := strSQL + '  WHERE ';
    strSQL := strSQL + '    CTR_NUMDUP = :NUMDUP   AND ';
    strSQL := strSQL + '    CTR_ESPDOC = :ESPDOC   AND ';
    strSQL := strSQL + '    CTR_PARCEL = :PARCEL   AND ';
    strSQL := strSQL + '    CTR_CODEMP = :CODEMP   AND ';
    strSQL := strSQL + '    CTR_CODCLI = :CODCLI       ';

    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      SQL.Text := strSQL;

      ParamByName('NUMDUP').AsString := strNumDup;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('PARCEL').AsString := strParcel;
      ParamByName('CODCLI').AsString := strCodCli;

      Open;

      Result := Not IsEmpty;

      If Not Result Then
        dtaDtaRec := 0;

    End;

    FreeAndNil(qryGen);

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fDuplicataExiste]');
    End;
  End;

End;

function TfrmGeraArqSerasaCon.pGerarConciliacao: Boolean;
var
  mArquivo: TextFile;
  stlSaida: TStringList;

  strNomeArquivo: String;
  strNomArqSaida: String;

  strLinha: String;
  strHeader: String;

  dtaDtaRec: TDate;

  strNumDup,
  strParcel,
  strEspDoc,
  strCodEmp,
  strCodCli,
  strDtaPag,
  strDtaRec: String;
begin

  try

    If Not fValidaArquivoRetorno Then
    Begin
      fMensagem('', 'Não é um arquivo de retorno do serasa!', ['&OK']);
      Result := False;
      Exit;
    End;

    {***********************************************************}
    {* GERAR ARQUIVO DE CONCILIACAO BASEADO NO ARQUIVO ENVIADO *}
    {********************************************************PH*}
    strNomeArquivo := AnsiReplaceStr(edtArqRetorno.Text, '"', '');
    strNomArqSaida := AnsiReplaceStr(fraArqSaida.edtDirectory.text, '"', '') + '\' + ExtractFileName(AnsiReplaceStr(strNomeArquivo, ExtractFileExt(strNomeArquivo), '.CON')); 


    AssignFile(mArquivo, strNomeArquivo);
    Reset(mArquivo);

    stlSaida := TStringList.Create;
    While Not Eof(mArquivo) Do
    Begin
      Readln(mArquivo, strLinha);

      {********************************************************************}
      {* COPIA O HEADER DO ARQUIVO DE ENVIO E COLOCA A PALAVRA 'CONCULIA' *}
      {*****************************************************************PH*}
      If (Copy(strLinha, 01, 02) = '00') Then
      Begin
        strHeader := Copy(strLinha, 01, 36);
        strHeader := strHeader + fPadR('CONCILIA', 08);
        strHeader := strHeader + Copy(strLinha, 45, 130);

        strDtaRec := Copy(strLinha, 45, 8);
        strDtaRec := Copy(strDtaRec, 7, 2) + '/' + Copy(strDtaRec, 5, 2) + '/' + Copy(strDtaRec, 1, 4);

        stlSaida.Add(strHeader);
      End
      Else If ((Copy(strLinha, 01, 02) = '01') And (Copy(strLinha, 17, 02) = '05')) Then
      Begin
//        intRegs05 := intRegs05 + 1;

        // 66  7         8        9        99
        // 6789012345678901234567890123456789
        // #D123456789012
        //               1
        //                12
        //                  123
        //                     12345678

        If Length(Trim(Copy(strLinha,68,32))) = 28 Then
        Begin
          strNumDup := Copy(strLinha, 68, 12);
          strParcel := Trim(Copy(strLinha, 80, 3));
          strEspDoc := Copy(strLinha, 83, 2);
          strCodEmp := Copy(strLinha, 85, 3);
          strCodCli := Copy(strLinha, 88, 8);
        End
        Else If Length(Trim(Copy(strLinha,68,32))) = 26 Then
        Begin
          strNumDup := Copy(strLinha, 68, 12);
          strParcel := Copy(strLinha, 80, 1);
          strEspDoc := Copy(strLinha, 81, 2);
          strCodEmp := Copy(strLinha, 83, 3);
          strCodCli := Copy(strLinha, 86, 8);
        End
        Else
        Begin
          strNumDup := Copy(strLinha, 68, 6);
          strParcel := Copy(strLinha, 74, 1);
          strEspDoc := Copy(strLinha, 75, 2);
          strCodEmp := Copy(strLinha, 77, 3);
          strCodCli := Copy(strLinha, 80, 8);
        End;

        If fDuplicataPaga(strNumDup,
                          strParcel,
                          strEspDoc,
                          strCodEmp,
                          strCodCli,
                          StrToDate(strDtaRec),
                          dtaDtaRec) Or

           ((Not fEmptyStr(strNumDup)) And
            (Not fDuplicataExiste(strNumDup,
                                 strParcel,
                                 strEspDoc,
                                 strCodEmp,
                                 strCodCli,
                                 dtaDtaRec))) Then
        Begin
          If dtaDtaRec <> 0 Then
            strDtaPag := FormatDateTime('yyyymmdd', dtaDtaRec)
          Else
            strDtaPag := fPadL('',8);
        End
        Else
          strDtaPag := fPadL('',8);
                                          // 058 a 065

        strLinha := Copy(strLinha, 1, 57) + strDtaPag + Copy(strLinha, 66, Length(strLinha) - 65);

        stlSaida.Add(strLinha);
      End
      Else If (Copy(strLinha, 01, 02) = '99') Then
      Begin
        stlSaida.Add(strLinha);
      End;

    End;

  finally
    CloseFile(mArquivo);
    stlSaida.SaveToFile(strNomArqSaida);
  end;

  FreeAndNil(stlSaida);
  Result := True;
end;

procedure TfrmGeraArqSerasaCon.btnGerConClick(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtArqRetorno.Text) Then
    fMensagem(Application.Title, 'Informe o arquivo a ser processado!', ['OK'])
  Else If fEmptyStr(fraArqSaida.edtDirectory.text) Then
    fMensagem(Application.Title, 'Informe o diretório de saída!', ['OK'])
  Else
  Begin
    btnGerCon.Enabled := False;
    btnSair.Enabled  := False;
    edtArqRetorno.Enabled := False;
    pnlInfo.Caption := 'Processando...';

    If pGerarConciliacao Then
      fMensagem('', 'Geração concluida com sucesso!', ['OK']);

    edtArqRetorno.Enabled := True;
    btnSair.Enabled  := True;
    btnGerCon.Enabled := True;
    pnlInfo.Caption := '';
  End;
end;

end.
