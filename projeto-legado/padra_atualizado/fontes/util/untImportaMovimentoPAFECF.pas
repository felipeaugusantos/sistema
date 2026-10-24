unit untImportaMovimentoPAFECF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, ComCtrls, DateUtils, Uni, frxClass, frxExportCSVTestabilidade;

type
  TfrmImportaMovimentoPAFECF = class(TfrmPai)
    pnlGeral: TPanel;
    lblProgresso: TLabel;
    pbProgresso: TProgressBar;
    btnImportar: TBitBtnLocked;
    procedure btnImportarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure pImportarAutomatico;

procedure pVerificaDocumentosComFalhaDeImportacao;
function fVerificaExistenciaPafPrincipal(strNumSer, strNumCoo: String): Boolean;
procedure pInserePafPrincipalRessincronizar(strNumSer, strNumCoo: String);


implementation

uses untImportaPAFECF, untFuncoesSimples, untListaLogErros, untModulo;

{$R *.dfm}

procedure pImportarAutomatico;
  Var
    importaPAF: TImportaPAFECF;
    intContador: Integer;
    strFinalizar: String;
    dtaInicio: TDateTime;
begin
  strFinalizar := ExtractFilePath(Application.ExeName) + '\finalizar.paf';
  TListaErros.Erros.Habilitada := True;

  dtaInicio := fNow();

  While True Do
  Begin
    If MinutesBetween(fNow(), dtaInicio) > TEMPO_EXECUCAO_IMPORTADOR_PDV Then
      Break;

//    If Not fLockImportacaoValido Then
//      Break;

    If VS_strLockImportacaoPDV <> fGetIdConnectionLock('IMPORTACAO_PAF_' + VS_strCodEmp, False) Then
    Begin
      Break;
    End;

    If FileExists(strFinalizar) Then
      Break;

    TListaErros.Erros.pLimpar;

    importaPAF := TImportaPAFECF.Create(Nil);
    importaPAF.pImportar;
    FreeAndNil(importaPAF);

    For intContador := 0 To TListaErros.Erros.Count -1 Do
    Begin
      frmModulo.fGravarRelErro(TListaErros.Erros[intContador].Msg,
        TListaErros.Erros[intContador].BugReport, frmModulo.GetMySqlStatementsHistory);
    End;

    pZerarTentativasLock('IMPORTACAO_PAF_' + VS_strCodEmp, False);

    Sleep(1000);
    Application.ProcessMessages;

//    pVerificaDocumentosComFalhaDeImportacao;
  End;

  TListaErros.Erros.pLimpar;

  For intContador := 1 To 5 Do
  Begin
    DeleteFile(strFinalizar)
  End;

  pDestravaLockForcado('IMPORTACAO_PAF_' + VS_strCodEmp, 0);
end;

procedure TfrmImportaMovimentoPAFECF.btnImportarClick(Sender: TObject);
  Var
    importaPAF: TImportaPAFECF;
begin
  inherited;
  If fImportadorPAFRodando Then
  Begin
    pMensagemOk('Importador automático em execução. Não é permitida a importação manual.');
    Exit;
  End;

  If fLockImportacao Then
  Begin
    Try
      importaPAF := TImportaPAFECF.Create(pbProgresso);
      importaPAF.pImportar;
      FreeAndNil(importaPAF);

      pMensagemOk('Importação concluída.');
    Finally
      fRemoveLockImportacao;
    End;
  End;
end;

procedure TfrmImportaMovimentoPAFECF.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  TListaErros.Erros.Habilitada := False;
  TListaErros.Erros.pLimpar;
end;

procedure TfrmImportaMovimentoPAFECF.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(btnImportar);
end;

procedure pVerificaDocumentosComFalhaDeImportacao;
  Var
    qryDocs: TUniQuery;
begin
  qryDocs := fCriaQuery(Nil);
  qryDocs.SQL.Add('SELECT ');
  qryDocs.SQL.Add('  FGO_DTAENT, FGO_NUMDOC, FGO_ESPDOC, DPG_SER_CF, DPG_COO_CF, FGO_HORENT, FGO_VLRCON ');
  qryDocs.SQL.Add('FROM ');
  qryDocs.SQL.Add('  FATGOR ');
  qryDocs.SQL.Add('  JOIN DAVPVG ON DPG_NUMDOC = FGO_NUMDOC AND DPG_ESPDOC = FGO_ESPDOC AND DPG_CODEMP = FGO_CODEMP ');
  qryDocs.SQL.Add('WHERE ');
  qryDocs.SQL.Add('  FGO_CODEMP = :CODEMP AND FGO_DTAENT >= :DTAENT AND FGO_JAFATU = 1 AND IFNULL(FGO_NUMFAT,"") = "" ');;

  qryDocs.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryDocs.ParamByName('DTAENT').AsDateTime := IncDay(VS_Date, -5);
  qryDocs.Open;

  While Not qryDocs.Eof Do
  Begin
    If Not fVerificaExistenciaPafPrincipal(qryDocs.FieldByName('DPG_SER_CF').AsString,
                                           qryDocs.FieldByName('DPG_COO_CF').AsString) Then
    Begin
      pInserePafPrincipalRessincronizar(qryDocs.FieldByName('DPG_SER_CF').AsString,
                                        qryDocs.FieldByName('DPG_COO_CF').AsString);
    End;

    qryDocs.Next;
  End;

  FreeAndNil(qryDocs);
end;

function fVerificaExistenciaPafPrincipal(strNumSer, strNumCoo: String): Boolean;
  Var
    qryPaf: TUniQuery;
    dtaIni: TDateTime;
  Const
    TEMPO_LIMITE_PARA_EXISTIR = 30;
begin

  Result := False;
  dtaIni := fNow();

  qryPaf := fCriaQuery(Nil);
  qryPaf.SQL.Add('SELECT COUNT(*) AS QTD FROM PAF_PRINCIPAL ');
  qryPaf.SQL.Add('WHERE ');
  qryPaf.SQL.Add('  PAF_ID_LOC = :ID_LOC AND ');
  qryPaf.SQL.Add('  PAF_ID_DOC = :ID_DOC ');


  While (SecondsBetween(fNow(), dtaIni) < TEMPO_LIMITE_PARA_EXISTIR) Do
  Begin
    qryPaf.Close;
    qryPaf.ParamByName('ID_LOC').AsString := strNumSer;
    qryPaf.ParamByName('ID_DOC').AsString := strNumCoo;
    qryPaf.Open;

    If qryPaf.FieldByName('QTD').AsInteger > 0 Then
    Begin
      Result := True;
      Break;
    End;

    Sleep(2000);
  End;

  FreeAndNil(qryPaf);
end;

procedure pInserePafPrincipalRessincronizar(strNumSer, strNumCoo: String);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  qryAux.SQL.Add('INSERT INTO PAF_PRINCIPAL (PAF_ID_LOC, PAF_ID_DOC, PAF_CODEMP, PAF_EXPORT, PAF_CONFER, PAF_DTAEMI) ');
  qryAux.SQL.Add('VALUES (:ID_LOC, :ID_DOC, :CODEMP, 0, 0, :DTAINI) ');

  qryAux.ParamByName('ID_LOC').AsString := strNumSer;
  qryAux.ParamByName('ID_DOC').AsString := strNumCoo;
  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAux.ParamByName('DTAINI').AsDateTime := VS_Date;
  qryAux.ExecSQL;

  FreeAndNil(qryAux);
end;

end.
