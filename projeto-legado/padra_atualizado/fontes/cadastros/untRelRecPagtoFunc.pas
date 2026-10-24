unit untRelRecPagtoFunc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiRelatorio, frxDesgn, frxClass, frxDBSet, frxDMPExport,
  frxExportPDF, frxExportHTML, frxExportXLS, frxExportRTF, DateUtils,
  RLFilters, RLDraftFilter, AppEvnts, Menus, StdCtrls, EditFocus,
  QColorLabel, ExtCtrls, Buttons, Mask, MaskEditFocus, Uni,
  UniDataSetProvider, DB, UniClientDataSet, BitBtnLockedIncrem, untFuncoesGenerica,
  Datasnap.Provider, Datasnap.DBClient, frxExportCSVTestabilidade, untTypesSistema,
  frxGradient,
  cxProgressBar,untTEnvioEmail;//MF: 281249 - 04/05/2023


type
  TfrmRelRecPagtoFunc = class(TfrmPaiRelatorio)
    Label1: TLabel;
    mskMesBas: TMaskEditFocus;
    cdsConPag: TUniClientDataSet;
    dspConPag: TUniDataSetProvider;
    dspResumo: TUniDataSetProvider;
    frxPagtoFuncJ: TfrxReport;
    Label3: TLabel;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    cdsConPagCODVER: TStringField;
    cdsConPagDESVER: TStringField;
    fltfldConPagVALLAN: TFloatField;
    cdsConPagCODFUN: TStringField;
    cdsConPagDEBCRE: TStringField;
    cdsConPagCODDEB: TStringField;
    cdsConPagDESDEB: TStringField;
    fltfldConPagVALDEB: TFloatField;
    cdsConPagVER_CODVER: TStringField;
    cdsConPagVER_DESVER: TStringField;
    cdsConPagFUN_NOMFUN: TStringField;
    cdsConPagNOMFUN: TStringField;
    edtTipMov: TEditFocus;
    cdsConPagEMP_NOMEMP: TStringField;
    cdsConPagEMP_ENDERE: TStringField;
    cdsConPagEMP_C_G_C_: TStringField;
    cdsConPagAGENCI: TStringField;
    cdsConPagNUMBCO: TStringField;
    cdsConPagCONTA_: TStringField;
    Label2: TLabel;
    edtCodFun: TEditFocus;
    edtDesFun: TEditFocus;
    Label4: TLabel;
    edtCodVer: TEditFocus;
    edtDesVer: TEditFocus;
    cdsConPagCODEMP: TStringField;
    Label28: TLabel;
    edtDescricaoEvento: TEditFocus;
    edtCodEvento: TEditFocus;
    rdgTipoPesquisa: TRadioGroup;
    frxReport_M_Evento: TfrxReport;
    frxReport_J_Evento: TfrxReport;
    frxOSJ_Evento: TfrxReport;
    frxOSM_Evento: TfrxReport;
    cdsRecibo: TUniClientDataSet;
    cdsReciboVALREC: TStringField;
    cdsReciboNOMREC: TStringField;
    cdsReciboVLREXT: TStringField;
    cdsReciboHISREC: TStringField;
    cdsReciboNROVIA: TStringField;
    cdsReciboDTAREC: TStringField;
    cdsReciboCPFFUN: TStringField;
    cdsReciboDTAEVE: TStringField;
    cdsReciboDTAEVEINC: TStringField;
    lbl3: TLabel;
    edtQtdVia: TEditFocus;
    frxGradientObject1: TfrxGradientObject;
    cdsConPagAUTFUN: TStringField;
    cdsConPagFunc: TUniClientDataSet;
    cdsConPagFuncCODVER: TStringField;
    cdsConPagFuncDESVER: TStringField;
    cdsConPagFuncVALLAN: TFloatField;
    cdsConPagFuncCODFUN: TStringField;
    cdsConPagFuncNOMFUN: TStringField;
    cdsConPagFuncDEBCRE: TStringField;
    cdsConPagFuncCODDEB: TStringField;
    cdsConPagFuncDESDEB: TStringField;
    cdsConPagFuncVALDEB: TFloatField;
    cdsConPagFuncVER_CODVER: TStringField;
    cdsConPagFuncVER_DESVER: TStringField;
    cdsConPagFuncFUN_NOMFUN: TStringField;
    cdsConPagFuncEMP_NOMEMP: TStringField;
    cdsConPagFuncEMP_ENDERE: TStringField;
    cdsConPagFuncEMP_C_G_C_: TStringField;
    cdsConPagFuncAGENCI: TStringField;
    cdsConPagFuncNUMBCO: TStringField;
    cdsConPagFuncCONTA_: TStringField;
    cdsConPagFuncCODEMP: TStringField;
    cdsConPagFuncAUTFUN: TStringField;
    cdsConPagEMAIL_: TStringField;
    cdsConPagFuncEMAIL_: TStringField;
    cdsLogEnvEmail: TUniClientDataSet;
    cdsLogEnvEmailCODFUN: TStringField;
    cdsLogEnvEmailNOMFUN: TStringField;
    cdsLogEnvEmailEMAIL_: TStringField;
    frxDBLog: TfrxDBDataset;
    frxRepLogEmail: TfrxReport;
    cdsLogEnvEmailENVIOU: TIntegerField;
    cdsLogEnvEmailSTATUS: TStringField;
    cdsReciboFunc: TUniClientDataSet;
    cdsReciboFuncVALREC: TStringField;
    cdsReciboFuncNOMREC: TStringField;
    cdsReciboFuncVLREXT: TStringField;
    cdsReciboFuncHISREC: TStringField;
    cdsReciboFuncNROVIA: TStringField;
    cdsReciboFuncDTAREC: TStringField;
    cdsReciboFuncCPFFUN: TStringField;
    cdsReciboFuncDTAEVE: TStringField;
    cdsReciboFuncDTAEVEINC: TStringField;
    cdsReciboEMAIL_: TStringField;
    cdsReciboFuncEMAIL_: TStringField;
    cdsReciboCODFUN: TStringField;
    cdsReciboFuncCODFUN: TStringField;
    cdsConPagHIST01: TStringField;
    cdsConPagFuncHIST01: TStringField;
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure mskMesBasExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodFunExit(Sender: TObject);
    procedure edtCodFunKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVerExit(Sender: TObject);
    procedure edtCodVerKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEventoExit(Sender: TObject);
    procedure edtCodEventoKeyPress(Sender: TObject; var Key: Char);
    procedure rdgTipoPesquisaClick(Sender: TObject);
    procedure edtDestinoExit(Sender: TObject);
  private
    FPais: TPais;
    arrfuncAutIncrem  : TConsultasArray;
    arrFuncionario    : TConsultasArray;
    arrTipoVerba      : TConsultasArray;
    arrEmpresa        : TConsultasArray;
    arrEvento         : TConsultasArray;

    thrSincEmail      : TThreadSincronizaEmails; //MF: 281249 - 04/05/2023

    function  fRetSQLSelect(strOpcSel: String): String;
    procedure pCarregaEvento;
    procedure pLoadReport(var frxModelo: TFrxReport; strCodLay: String; strTipImp: String = 'J');
    function fEnviaRecibosEmailMensal(pgbProgresso: TcxProgressBar): Boolean;
    function pEnviarEmail(strArquivo, strDestinatario,
      strNomeDestinatario: String; blnEnviarMensagem: Boolean): Boolean;
    procedure pLogEnvioEmail(strCodFunc, strNomFunc, strEmailFunc: String; blnEnviou: Boolean);
    procedure pPrintReportLogEmail;
    function fEnviaRecibosEmailEventos(pgbProgresso: TcxProgressBar): Boolean;
    function fValidaEmail(strEmail: String): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  public
    { Public declarations }

  end;

var
  frmRelRecPagtoFunc: TfrmRelRecPagtoFunc;

implementation

uses untFuncoesSimples, untModuloSPR,  StrUtils, untConsultas, untFuncoesConsulta,
     untValorPorExtenso, untControlePagtoFunc, untGravando;

{$R *.dfm}

procedure TfrmRelRecPagtoFunc.pLoadReport(var frxModelo: TFrxReport; strCodLay: String; strTipImp: String = 'J');
Var
  FLayImp: TUniQuery;
  mmsLoad: TStream;
begin
  Try
    FLayImp := fCriaQuery(Nil);
    Try
      With FLayImp, SQL Do
      Begin
        Close;
        Clear;
        Add('SELECT * ');
        Add('  FROM LAYIMP');
        Add(' WHERE LAY_TIPLAY = :TIPLAY ');
        Add('   AND LAY_CODEMP = :CODEMP ');
        Add('   AND LAY_CODLAY = :CODLAY ');
        Add(' ORDER BY LAY_DTAALT DESC,');
        Add('          LAY_HORALT DESC ');
        Add(' LIMIT 1');
        ParamByName('CODLAY').AsString := strCodLay;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('TIPLAY').AsString := IIF(strTipImp = 'J','L','M');

        Open;
        If Not IsEmpty Then
        Begin
          mmsLoad := CreateBlobStream(FieldByName('LAY_RELFR3'), bmRead);
          frxModelo.LoadFromStream(mmsLoad);
        End;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fLoadReport]');
      End;
    End;
  Finally
    FreeAndNil(mmsLoad);
    pFreeAndNil(FLayImp);
  End;
end;

//MF: 281249 - 04/05/2023
function TfrmRelRecPagtoFunc.pEnviarEmail(strArquivo, strDestinatario, strNomeDestinatario: String; blnEnviarMensagem: Boolean): Boolean;
  Var
    arrArquivos, arrDestinatarios : TStringArray;
begin
  pCriarArrayAnexosEDestinatarios(strArquivo, strDestinatario, arrDestinatarios, arrArquivos);

  Result := TEnvioEmail.EnviarEmailSemMensagemConfirmacao(Self,
                                                          strLoginUsuarioLogado,
                                                          'Recibo de Pagamento - ' + strNomeDestinatario,
                                                          arrDestinatarios,
                                                          [],
                                                          [],
                                                          ['Segue Recibo de Pagamento anexo.'],
                                                          arrArquivos,
                                                          False,
                                                          thrSincEmail);
end;

//MF: 281249 - 04/05/2023
procedure TfrmRelRecPagtoFunc.pLogEnvioEmail(strCodFunc, strNomFunc, strEmailFunc: String; blnEnviou: Boolean);
Begin
  cdsLogEnvEmail.Append;
  cdsLogEnvEmailCODFUN.asString := strCodFunc;
  cdsLogEnvEmailNOMFUN.asString := strNomFunc;

  If (Not fEmptyStr(strEmailFunc)) Then
    cdsLogEnvEmailEMAIL_.asString := strEmailFunc
  Else
    cdsLogEnvEmailEMAIL_.asString := 'E-mail não cadastrado';

  If (blnEnviou) Then
  Begin
    cdsLogEnvEmailSTATUS.asString := 'E-MAILS DE FUNCIONARIOS ENVIADOS:';
    cdsLogEnvEmailENVIOU.asInteger := 1;
  End
  Else
  Begin
    cdsLogEnvEmailSTATUS.asString := 'E-MAILS DE FUNCIONARIOS NÃO ENVIADOS:';
    cdsLogEnvEmailENVIOU.asInteger := 0;
  End;

  cdsLogEnvEmail.Post;
End;

//MF: 281249 - 09/05/2023
function TfrmRelRecPagtoFunc.fValidaEmail(strEmail: String): Boolean;
var
  intCount: Integer;
begin


  intCount :=(Length(strEmail) - Length(StringReplace(strEmail,'@', '', [rfReplaceAll])));

  If (intCount <> 1) Then
  Begin
    Result := False;
  End
  Else
  Begin
    If (Pos('@', strEmail) > 1) Then
    Begin
      Delete(StrEmail, 1, pos('@', strEmail));
      Result := (Length(strEmail) > 0) and (Pos('.', strEmail) > 2);
    End
    Else
      Result := False;
  End;
end;

//MF: 281249 - 04/05/2023
function TfrmRelRecPagtoFunc.fEnviaRecibosEmailMensal(pgbProgresso: TcxProgressBar): Boolean;
var
  strCodFuncAnt: String;

  procedure pDisparaEmailFunc(strCodFunc, strNomFunc, strEmailFunc: String);
  Var
    strNomeArquivo,
    strCaminho,
    strNomeArqCompl: String;
    blnEnviado: Boolean;
  Begin
    blnEnviado := True;
    //GERA O ARQUIVO PDF DO RECIBO DO FUNCIONARIO SELECIONADO - INICIO
    strCaminho := ExtractFilePath(Application.ExeName) + 'RECPGTFUNC\';

    If Not DirectoryExists(strCaminho) Then
      CreateDir(strCaminho);

    strNomeArquivo := strCodFunc+FormatDateTime('yyyymmdd', Date)+'M.PDF';

    strNomeArqCompl := strCaminho + strNomeArquivo;

    frxPagtoFuncJ.Script.Variables['PERIODO']:= mskMesBas.Text;
    If Assigned(frxPagtoFuncJ.FindObject('Memo19')) Then
      TfrxMemoView(frxPagtoFuncJ.FindObject('Memo19')).Memo.Text := mskMesBas.Text;
    cdsConPagFunc.IndexFieldNames := 'FUN_NOMFUN;VER_CODVER';

    frxRelatorio.DataSet := cdsConPagFunc;

    frxPagtoFuncJ.FileName := strNomeArqCompl;

    frxPagtoFuncJ.PrintOptions.ShowDialog := False;
    frxPagtoFuncJ.PrepareReport();
    frxExpPDF.ShowDialog := False;
    frxExpPDF.ShowProgress :=  False;
    frxExpPDF.OverwritePrompt := False;
    frxExpPDF.DefaultPath := strCaminho;
    frxExpPDF.FileName := frxPagtoFuncJ.FileName;

    frxPagtoFuncJ.Export(frxExpPDF);
    //GERA O ARQUIVO PDF DO RECIBO DO FUNCIONARIO SELECIONADO - FIM
    try
      try
        blnEnviado := pEnviarEmail(strNomeArqCompl, strEmailFunc, strNomFunc, True);
      except
        blnEnviado := False;
      end;
    finally
      pLogEnvioEmail(strCodFunc, strNomFunc, strEmailFunc, blnEnviado);

      //If FileExists(strNomeArqCompl) Then
      //  DeleteFile(strNomeArqCompl);
    End;

  End;


Begin
  if (cdsConPag.Active) and (Not cdsConPag.IsEmpty) Then
  Begin
    cdsConPagFunc.CreateDataSet;
    cdsConPagFunc.Open;

    cdsLogEnvEmail.Close;
    cdsLogEnvEmail.CreateDataSet;
    cdsLogEnvEmail.Open;

    cdsConPag.First;

    strCodFuncAnt := cdsConPag.FieldByName('CODFUN').AsString;

    While not cdsConPag.EOF do
    Begin//While
      If (strCodFuncAnt <> cdsConPag.FieldByName('CODFUN').AsString) Then
      Begin
        If (Trim(cdsConPagFunc.FieldByName('EMAIL_').AsString) <> '') Then
        Begin
          If (fValidaEmail(cdsConPagFunc.FieldByName('EMAIL_').AsString)) Then
            pDisparaEmailFunc(cdsConPagFunc.FieldByName('CODFUN').AsString,
                             cdsConPagFunc.FieldByName('FUN_NOMFUN').AsString,
                             cdsConPagFunc.FieldByName('EMAIL_').AsString )
          Else
            pLogEnvioEmail(cdsConPagFunc.FieldByName('CODFUN').AsString, cdsConPagFunc.FieldByName('FUN_NOMFUN').AsString,
                                          cdsConPagFunc.FieldByName('EMAIL_').AsString, False);
        End
        Else
          pLogEnvioEmail(cdsConPagFunc.FieldByName('CODFUN').AsString, cdsConPagFunc.FieldByName('FUN_NOMFUN').AsString, '', False);

        cdsConPagFunc.EmptyDataSet;
      End;

      cdsConPagFunc.Append;
      cdsConPagFunc.FieldByName('VER_DESVER').AsString := cdsConPag.FieldByName('VER_DESVER').AsString;
      cdsConPagFunc.FieldByName('VER_CODVER').AsString := cdsConPag.FieldByName('VER_CODVER').AsString;
      cdsConPagFunc.FieldByName('FUN_NOMFUN').AsString := cdsConPag.FieldByName('FUN_NOMFUN').AsString;

      cdsConPagFunc.FieldByName('EMP_NOMEMP').AsString := cdsConPag.FieldByName('EMP_NOMEMP').AsString;
      cdsConPagFunc.FieldByName('EMP_ENDERE').AsString := cdsConPag.FieldByName('EMP_ENDERE').AsString;
      cdsConPagFunc.FieldByName('EMP_C_G_C_').AsString := fFormataCpfCgc(cdsConPag.FieldByName('EMP_C_G_C_').AsString, FPais);

      cdsConPagFunc.FieldByName('CODVER').AsString := cdsConPag.FieldByName('CODVER').AsString;
      cdsConPagFunc.FieldByName('DESVER').AsString := cdsConPag.FieldByName('DESVER').AsString;
      cdsConPagFunc.FieldByName('VALLAN').AsFloat  := cdsConPag.FieldByName('VALLAN').AsFloat;
      cdsConPagFunc.FieldByName('CODFUN').AsString := cdsConPag.FieldByName('CODFUN').AsString;
      cdsConPagFunc.FieldByName('NOMFUN').AsString := cdsConPag.FieldByName('NOMFUN').AsString;
      cdsConPagFunc.FieldByName('NUMBCO').AsString := cdsConPag.FieldByName('NUMBCO').AsString;
      cdsConPagFunc.FieldByName('AGENCI').AsString := cdsConPag.FieldByName('AGENCI').AsString;
      cdsConPagFunc.FieldByName('CONTA_').AsString := cdsConPag.FieldByName('CONTA_').AsString;
      cdsConPagFunc.FieldByName('DEBCRE').AsString := cdsConPag.FieldByName('DEBCRE').AsString;
      cdsConPagFunc.FieldByName('CODDEB').AsString := cdsConPag.FieldByName('CODDEB').AsString;
      cdsConPagFunc.FieldByName('DESDEB').AsString := cdsConPag.FieldByName('DESDEB').AsString;
      cdsConPagFunc.FieldByName('VALDEB').AsFloat  := cdsConPag.FieldByName('VALDEB').AsFloat;
      cdsConPagFunc.FieldByName('CODEMP').AsString := cdsConPag.FieldByName('CODEMP').AsString;
      cdsConPagFunc.FieldByName('AUTFUN').AsString := cdsConPag.FieldByName('AUTFUN').AsString;
      cdsConPagFunc.FieldByName('EMAIL_').AsString := cdsConPag.FieldByName('EMAIL_').AsString;
      cdsConPagFunc.FieldByName('HIST01').AsString := cdsConPag.FieldByName('HIST01').AsString;
      cdsConPagFunc.Post;

      strCodFuncAnt := cdsConPag.FieldByName('CODFUN').AsString;
      cdsConPag.Next;
    End;//While

    //Dispara o e-mail do ultimo da fila
    If (Not fEmptyStr(cdsConPagFunc.FieldByName('EMAIL_').AsString) ) Then
    Begin
      If (fValidaEmail(cdsConPagFunc.FieldByName('EMAIL_').AsString)) Then
        pDisparaEmailFunc(cdsConPagFunc.FieldByName('CODFUN').AsString,
                              cdsConPagFunc.FieldByName('FUN_NOMFUN').AsString,
                              cdsConPagFunc.FieldByName('EMAIL_').AsString )
      Else
        pLogEnvioEmail(cdsConPagFunc.FieldByName('CODFUN').AsString, cdsConPagFunc.FieldByName('FUN_NOMFUN').AsString,
                              cdsConPagFunc.FieldByName('EMAIL_').AsString, False);
    End
    Else
      pLogEnvioEmail(cdsConPagFunc.FieldByName('CODFUN').AsString, cdsConPagFunc.FieldByName('FUN_NOMFUN').AsString, '', False);

    If Assigned(thrSincEmail) Then
    Begin
      if thrSincEmail.QuantidadeEmails > 0 then
      begin
        thrSincEmail.Start;

        TListaThreadsSincronizaEmails.GetInstance.pAdicionar(thrSincEmail);
      end;
    End;

    cdsConPagFunc.EmptyDataSet;
    cdsConPagFunc.Close;

    Result := True;
  End
  Else
    Result := False;
End;

//MF: 281249 - 05/05/2023
function TfrmRelRecPagtoFunc.fEnviaRecibosEmailEventos(pgbProgresso: TcxProgressBar): Boolean;
var
  strCodFuncAnt: String;

  procedure pDisparaEmailFunc(strCodFunc, strNomFunc, strEmailFunc: String);
  Var
    strNomeArquivo,
    strCaminho,
    strNomeArqCompl: String;
    blnEnviado: Boolean;
  Begin
    blnEnviado := True;
    //GERA O ARQUIVO PDF DO RECIBO DO FUNCIONARIO SELECIONADO - INICIO
    strCaminho := ExtractFilePath(Application.ExeName) + 'RECPGTFUNC\';

    If Not DirectoryExists(strCaminho) Then
      CreateDir(strCaminho);

    strNomeArquivo := strCodFunc+FormatDateTime('yyyymmdd', Date)+'E.PDF';

    strNomeArqCompl := strCaminho + strNomeArquivo;

    frxRelatorio.DataSet := cdsReciboFunc;

    frxOSJ_Evento.FileName := strNomeArqCompl;

    frxOSJ_Evento.PrintOptions.ShowDialog := False;
    frxOSJ_Evento.PrepareReport();
    frxExpPDF.ShowDialog := False;
    frxExpPDF.ShowProgress :=  False;
    frxExpPDF.OverwritePrompt := False;
    frxExpPDF.DefaultPath := strCaminho;
    frxExpPDF.FileName := frxOSJ_Evento.FileName;

    frxOSJ_Evento.Export(frxExpPDF);
    //GERA O ARQUIVO PDF DO RECIBO DO FUNCIONARIO SELECIONADO - FIM
    try
      try
        blnEnviado := pEnviarEmail(strNomeArqCompl, strEmailFunc, strNomFunc, True);
      except
        blnEnviado := False;
      end;
    finally
      pLogEnvioEmail(strCodFunc, strNomFunc, strEmailFunc, blnEnviado);

      //If FileExists(strNomeArqCompl) Then
      //  DeleteFile(strNomeArqCompl);
    End;

  End;


Begin
  if (cdsRecibo.Active) and (Not cdsRecibo.IsEmpty) Then
  Begin
    cdsReciboFunc.CreateDataSet;
    cdsReciboFunc.Open;

    cdsLogEnvEmail.Close;
    cdsLogEnvEmail.CreateDataSet;
    cdsLogEnvEmail.Open;

    cdsRecibo.First;


    strCodFuncAnt := cdsRecibo.FieldByName('CODFUN').AsString;

    While not cdsRecibo.EOF do
    Begin//While
      If (strCodFuncAnt <> cdsRecibo.FieldByName('CODFUN').AsString) Then
      Begin
        If (Trim(cdsReciboFunc.FieldByName('EMAIL_').AsString) <> '') Then
        Begin
          If (fValidaEmail(cdsReciboFunc.FieldByName('EMAIL_').AsString)) Then
            pDisparaEmailFunc(cdsReciboFunc.FieldByName('CODFUN').AsString,
                              cdsReciboFunc.FieldByName('NOMREC').AsString,
                              cdsReciboFunc.FieldByName('EMAIL_').AsString )
          Else
            pLogEnvioEmail(cdsReciboFunc.FieldByName('CODFUN').AsString, cdsReciboFunc.FieldByName('NOMREC').AsString,
                                          cdsReciboFunc.FieldByName('EMAIL_').AsString, False);
        End
        Else
          pLogEnvioEmail(cdsReciboFunc.FieldByName('CODFUN').AsString, cdsReciboFunc.FieldByName('NOMREC').AsString, '', False);

        cdsReciboFunc.EmptyDataSet;
      End;

      cdsReciboFunc.Append;

      cdsReciboFuncNOMREC.AsString    := cdsRecibo.FieldByName('NOMREC').AsString;
      cdsReciboFuncVALREC.AsFloat     := cdsRecibo.FieldByName('VALREC').AsFloat;
      cdsReciboFuncCPFFUN.AsString    := cdsRecibo.FieldByName('CPFFUN').AsString;
      cdsReciboFuncDTAEVE.AsString    := cdsRecibo.FieldByName('DTAEVE').AsString;
      cdsReciboFuncEMAIL_.AsString    := cdsRecibo.FieldByName('EMAIL_').AsString;
      cdsReciboFuncCODFUN.AsString    := cdsRecibo.FieldByName('CODFUN').AsString;

      cdsReciboFuncDTAEVEINC.AsString := cdsRecibo.FieldByName('DTAEVEINC').AsString;

      cdsReciboFuncVLREXT.AsString    := cdsRecibo.FieldByName('VLREXT').AsString;
      cdsReciboFuncHISREC.AsString    := cdsRecibo.FieldByName('HISREC').AsString;
      cdsReciboFuncDTAREC.AsString    := cdsRecibo.FieldByName('DTAREC').AsString;
      cdsReciboFuncNROVIA.AsInteger   := cdsRecibo.FieldByName('NROVIA').AsInteger;

      cdsReciboFunc.Post;

      strCodFuncAnt := cdsRecibo.FieldByName('CODFUN').AsString;
      cdsRecibo.Next;
    End;//While

    //Dispara o e-mail do ultimo da fila
    If (Not fEmptyStr(cdsReciboFunc.FieldByName('EMAIL_').AsString)) Then
    Begin
      If (fValidaEmail(cdsReciboFunc.FieldByName('EMAIL_').AsString)) Then
        pDisparaEmailFunc(cdsReciboFunc.FieldByName('CODFUN').AsString,
                              cdsReciboFunc.FieldByName('NOMREC').AsString,
                              cdsReciboFunc.FieldByName('EMAIL_').AsString )
        Else
          pLogEnvioEmail(cdsReciboFunc.FieldByName('CODFUN').AsString, cdsReciboFunc.FieldByName('NOMREC').AsString,
                                          cdsReciboFunc.FieldByName('EMAIL_').AsString, False);
    End
    Else
      pLogEnvioEmail(cdsReciboFunc.FieldByName('CODFUN').AsString, cdsReciboFunc.FieldByName('NOMREC').AsString, '', False);


    If Assigned(thrSincEmail) Then
    Begin
      if thrSincEmail.QuantidadeEmails > 0 then
      begin
        thrSincEmail.Start;

        TListaThreadsSincronizaEmails.GetInstance.pAdicionar(thrSincEmail);
      end;
    End;

    cdsReciboFunc.EmptyDataSet;
    cdsReciboFunc.Close;

    Result := True;
  End
  Else
    Result := False;
End;

procedure TfrmRelRecPagtoFunc.pPrintReportLogEmail;
begin
  If (cdsLogEnvEmail.Active) and (Not cdsLogEnvEmail.IsEmpty) Then
  Begin
    cdsLogEnvEmail.IndexFieldNames := 'STATUS;NOMFUN';
    frxRepLogEmail.Script.Variables['NOME_EMPRESA'] := fRetNomeEmpresa(VS_strCodEmp);
    frxRepLogEmail.Script.Variables['TOT_REGISTROS'] := IntToStr(cdsLogEnvEmail.RecordCount);

    frxRepLogEmail.Script.Variables['TIPO_PESQUISA'] := IIF(rdgTipoPesquisa.ItemIndex = 0, 'Mensal', 'Evento');
    frxRepLogEmail.Script.Variables['EMPRESA'] := IIF(fEmptyStr(edtCodEmpresa.Text), 'TODOS', edtCodEmpresa.Text + ' - ' + edtDesEmpresa.Text);
    frxRepLogEmail.Script.Variables['MES_BASE'] := mskMesBas.Text + ' ' + edtTipMov.Text;
    frxRepLogEmail.Script.Variables['EVENTO'] := IIF(fEmptyStr(edtCodEvento.Text), 'TODOS', edtCodEvento.Text + ' - ' + edtDescricaoEvento.Text);
    frxRepLogEmail.Script.Variables['FUNCIONARIO'] := IIF(fEmptyStr(edtCodFun.Text), 'TODOS', edtCodFun.Text + ' - ' + edtDesFun.Text);
    frxRepLogEmail.Script.Variables['TIPO_VERBA'] := IIF(fEmptyStr(edtCodVer.Text), 'TODOS', edtCodVer.Text + ' - ' + edtDesVer.Text);

    frxRepLogEmail.PrepareReport;
    frxRepLogEmail.ShowReport;
  End;
end;

procedure TfrmRelRecPagtoFunc.btnImprimirClick(Sender: TObject);
Var
  qckRel     : TfrxReport;
  strFunAnt  : String;
  intQtdDeb  : Integer;
  intPosDeb  : Integer;
  intContad  : Integer;
  intPosNov  : Integer;
  intPosAtu  : Integer;
  blnGraCre  : Boolean;
  blnGraDeb  : Boolean;
  qryCon     : TUniQuery;
  stlCodDeb  : TStringList;
  stlDesDeb  : TStringList;
  stlValDeb  : TStringList;
  strfuncionario,
  strTipoVerba,
  strEmpresa: String;
  AContador: Integer;
//  strNomImpLOCAL: String;     // esta variavel ja existe no ancestral
//  strTipImpLOCAL: String;     // esta variavel ja existe no ancestral
//  qryCfgRelLOCAL: TUniQuery;  // esta variavel ja existe no ancestral
begin
  inherited;
  if (rdgTipoPesquisa.ItemIndex = 0) and
     (fEmptyStr(fTiraCaracEspeciais(mskMesBas.Text))) then
  begin
    fMensagem('ATENÇÃO!','O Mês Base deve ser preenchido!',['&Ok']);
    blnImprime := False;
    pSetFocus(mskMesBas);
    Exit;
  end;

  if (rdgTipoPesquisa.ItemIndex = 1) and
     (fEmptyStr(edtCodEvento.Text)) then
  begin
    fMensagem('ATENÇÃO!','O evento deve ser preenchido!',['&Ok']);
    blnImprime := False;
    pSetFocus(edtCodEvento);
    Exit;
  end;

  If blnImprime Then
  Begin
    pnlInfo.Caption := 'Gerando Relatório...';
    pnlInfo.Repaint;
    Application.ProcessMessages;

    intQtdDeb := 0;
    Try
      if rdgTipoPesquisa.ItemIndex = 0 then
      begin
        {*****************************}
        {* CARREGA O LAYOUT DO BANCO *}
        {**************************LM*}
        strNomImp := frxPagtoFuncJ.PrintOptions.Printer;
        pLoadReport(frxPagtoFuncJ, 'RECPFM', 'J');
        frxPagtoFuncJ.PrintOptions.Printer := strNomImp;

       {*****************************}
       {* CARREGA OS DADOS DA FOLHA *}
       {**************************PZ*}
        TCadVer.Create(Nil).AtualizaDadosDeVersoesAnteriores(mskMesBas.Text, edtCodEmpresa.Text , edtTipMov.Text);

        With frmModuloSPR.qryRelatorio Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(fretSQLSelect('C'));

          if not fEmptyStr(edtCodEmpresa.Text) then
            pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', frmModuloSPR.qryRelatorio);

          ParamByName('MESBAS').AsDate   := strToDate('01/' + mskMesBas.Text);
          ParamByName('TIPMOV').AsString := edtTipMov.Text;

          If Not fEmptyStr(edtCodFun.Text) Then
            pSetaParam(edtCodFun.Text, arrFuncionario, strfuncionario, 'CODFUN', frmModuloSPR.qryRelatorio);

          If Not fEmptyStr(edtCodVer.Text) Then
            pSetaParam(edtCodVer.Text, arrTipoVerba, strTipoVerba, 'CODVER', frmModuloSPR.qryRelatorio);

          Open;
          pSetaClient(frmModuloSPR.qryRelatorio);
        End;


        If (Not frmModuloSPR.qryRelatorio.IsEmpty) Then
        Begin
          qckRel := frxPagtoFuncJ;
          qckRel.DotMatrixReport           := False;
          qckRel.PrintOptions.PrintMode    := pmScale;
          qckRel.PrintOptions.PrintOnSheet := 9; //A4

          qryCon    := fCriaQuery(Self);
          stlCodDeb := TStringList.Create;
          stlDesDeb := TStringList.Create;
          stlValDeb := TStringList.Create;

          {********************************** *}
          {* CARREGA A ESTRUTURA DO RELATORIO *}
          {* PARA O CLIENTDATASET.            *}
          {*********************************PZ*}
          With qryCon Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(fRetSQLSelect(''));
            Open;
            pSetaClient(qryCon);
            cdsConPag.CreateDataSet;
          End;

          {*********************************************}
          {* AQUI IRÁ INTERCALAR OS CRÉDITOS E DÉBITOS *}
          {* PARA SER POSSÍVEL IMPRIMIR OS CRÉDITOS E  *}
          {* DEBITOS EM COLUNAS SEPARADAS.             *}
          {******************************************PZ*}
          With frmModuloSPR.qryRelatorio Do
          Begin
            First;
            strFunAnt := '';
            blnGraCre := False;
            blnGraDeb := False;
            intPosDeb := 0;
            cdsConPag.EmptyDataSet;

            While Not Eof Do
            Begin

              {***********************************}
              {* VERIFICA SE MUDOU O FUNCIONÁRIO *}
              {********************************PZ*}
              If (strFunAnt <> FieldByName('CODFUN').AsString + FieldByName('AUTFUN').AsString) Then
              Begin
                stlCodDeb.Clear;
                stlDesDeb.Clear;
                stlValDeb.Clear;
                intPosDeb := 0;
                intPosAtu := RecNo;
                strFunAnt := FieldByName('CODFUN').AsString + FieldByName('AUTFUN').AsString;
                First;

                {***************************************}
                {* CARREGA TODOS OS DÉBITOS EXISTENTES *}
                {* DE UM FUNCIONÁRIO.                  *}
                {************************************PZ*}
                While Not Eof Do
                Begin
                  If (FieldByName('CODFUN').AsString + FieldByName('AUTFUN').AsString = strFunAnt) And (FieldByName('DEBCRE').AsString = 'D') Then
                  Begin
                    stlCodDeb.Add(FieldByName('CODVER').AsString);
                    stlDesDeb.Add(FieldByName('DESVER').AsString);
                    stlValDeb.Add(FormatFloat('#,##0.00', FieldByName('VALLAN').AsFloat * (-1)));
                  End;
                  Next;
                End;

                intQtdDeb := stlCodDeb.Count;

                RecNo := intPosAtu;
              End;

              {****************************}
              {* VERIFICA SE É UM CRÉDITO *}
              {* SE FOR GRAVA NO CLIENT.  *}
              {*************************PZ*}
              If (FieldByName('DEBCRE').AsString = 'C') Then
              Begin
                cdsConPag.Append;

                cdsConPag.FieldByName('VER_DESVER').AsString := FieldByName('VER_DESVER').AsString;
                cdsConPag.FieldByName('VER_CODVER').AsString := FieldByName('VER_CODVER').AsString;
                cdsConPag.FieldByName('FUN_NOMFUN').AsString := FieldByName('FUN_NOMFUN').AsString;

                cdsConPag.FieldByName('EMP_NOMEMP').AsString := FieldByName('EMP_NOMEMP').AsString;
                cdsConPag.FieldByName('EMP_ENDERE').AsString := FieldByName('EMP_ENDERE').AsString;
                cdsConPag.FieldByName('EMP_C_G_C_').AsString := fFormataCpfCgc(FieldByName('EMP_C_G_C_').AsString, FPais);

                cdsConPag.FieldByName('CODVER').AsString := FieldByName('CODVER').AsString;
                cdsConPag.FieldByName('DESVER').AsString := FieldByName('DESVER').AsString;
                cdsConPag.FieldByName('VALLAN').AsFloat  := FieldByName('VALLAN').AsFloat;
                cdsConPag.FieldByName('CODFUN').AsString := FieldByName('CODFUN').AsString;
                cdsConPag.FieldByName('NOMFUN').AsString := FieldByName('NOMFUN').AsString;
                cdsConPag.FieldByName('NUMBCO').AsString := FieldByName('NUMBCO').AsString;
                cdsConPag.FieldByName('AGENCI').AsString := FieldByName('AGENCI').AsString;
                cdsConPag.FieldByName('CONTA_').AsString := FieldByName('CONTA_').AsString;
                cdsConPag.FieldByName('DEBCRE').AsString := FieldByName('DEBCRE').AsString;
                cdsConPag.FieldByName('CODDEB').AsString := ' ';
                cdsConPag.FieldByName('DESDEB').AsString := ' ';
                cdsConPag.FieldByName('VALDEB').AsFloat  := 0;
                cdsConPag.FieldByName('CODEMP').AsString := FieldByName('CODEMP').AsString;
                cdsConPag.FieldByName('AUTFUN').AsString := FieldByName('AUTFUN').AsString;
                cdsConPag.FieldByName('EMAIL_').AsString := FieldByName('EMAIL_').AsString;
                cdsConPag.FieldByName('HIST01').AsString := FieldByName('HIST01').AsString;
                cdsConPag.Post;
                blnGraCre := True;
              End;

              {******************************************}
              {* POSICIONA NO PROXIMO REGISTRO DA QUERY *}
              {***************************************PZ*}
              intPosNov := RecNo + 1;
              RecNo     := RecNo + 1;

              {*****************************************}
              {* VERIFICA SE O PROXIMO REGISTRO SE     *}
              {* REFERE AO MESMO FUNCIONÁRIO. SE FOR   *}
              {* O MESMO E POSSUIR VERBAS DE DEBITO,   *}
              {* E HOUVE GRAVAÇÃO DE UM CRÉDITO, GRAVA *}
              {* O DEBITO NA MESMA LINHA DO CREDITO.    *}
              {**************************************PZ*}
              If (FieldByName('CODFUN').AsString + FieldByName('AUTFUN').AsString = strFunAnt) And (intQtdDeb > intPosDeb) And (blnGraCre) Then
              Begin
                If ((intPosNov - 1) < RecordCount) Then
                  RecNo := RecNo - 1;

                cdsConPag.Edit;
                cdsConPag.FieldByName('CODDEB').AsString := stlCodDeb[intPosDeb];
                cdsConPag.FieldByName('DESDEB').AsString := stlDesDeb[intPosDeb];
                cdsConPag.FieldByName('VALDEB').AsFloat  := fStrToFloat(stlValDeb[intPosDeb]);
                cdsConPag.Post;
                blnGraDeb := True;
                Inc(intPosDeb);
              End
              {*******************************************}
              {* SE FOR O MESMO FUNCIONARIO E SE POSSUIR *}
              {* DEBITOS E NÃO HOUVE GRAVAÇÃO DE CRÉDITO *}
              {* IRÁ GRAVAR TODOS OS DÉBITOS.            *}
              {****************************************PZ*}
              Else If {(FieldByName('CODFUN').AsString = strFunAnt) And}
                      (intQtdDeb > intPosDeb)                      And
                      (Not blnGraCre)                              Then
              Begin
                If ((intPosNov - 1) < RecordCount) Then
                  RecNo := RecNo - 1;

                For intContad := intPosDeb To stlCodDeb.Count - 1 Do
                Begin
                  cdsConPag.Append;
                  cdsConPag.FieldByName('CODVER').AsString := ' ';
                  cdsConPag.FieldByName('DESVER').AsString := ' ';
                  cdsConPag.FieldByName('VALLAN').AsFloat  := 0;
                  cdsConPag.FieldByName('CODFUN').AsString := FieldByName('CODFUN').AsString;
                  cdsConPag.FieldByName('NOMFUN').AsString := FieldByName('NOMFUN').AsString;
                  //cdsConPag.FieldByName('NUMBCO').AsString := FieldByName('NUMBCO').AsString;
                  //cdsConPag.FieldByName('AGENCI').AsString := FieldByName('AGENCI').AsString;
                  //cdsConPag.FieldByName('CONTA_').AsString := FieldByName('CONTA_').AsString;
                  cdsConPag.FieldByName('DEBCRE').AsString := FieldByName('DEBCRE').AsString;
                  cdsConPag.FieldByName('CODDEB').AsString := stlCodDeb[intPosDeb];
                  cdsConPag.FieldByName('DESDEB').AsString := stlDesDeb[intPosDeb];
                  cdsConPag.FieldByName('VALDEB').AsFloat  := fStrToFloat(stlValDeb[intPosDeb]);

                  cdsConPag.FieldByName('VER_CODVER').AsString := '999';
                  cdsConPag.FieldByName('VER_DESVER').AsString := FieldByName('VER_DESVER').AsString;
                  cdsConPag.FieldByName('FUN_NOMFUN').AsString := FieldByName('FUN_NOMFUN').AsString;
                  cdsConPag.FieldByName('CODEMP').AsString := FieldByName('CODEMP').AsString;

                  cdsConPag.FieldByName('EMP_NOMEMP').AsString := FieldByName('EMP_NOMEMP').AsString;
                  cdsConPag.FieldByName('EMP_ENDERE').AsString := FieldByName('EMP_ENDERE').AsString;
                  cdsConPag.FieldByName('EMP_C_G_C_').AsString := fFormataCpfCgc(FieldByName('EMP_C_G_C_').AsString, FPais);
                  cdsConPag.FieldByName('AUTFUN').AsString := FieldByName('AUTFUN').AsString;
                  cdsConPag.FieldByName('EMAIL_').AsString := FieldByName('EMAIL_').AsString;
                  cdsConPag.FieldByName('HIST01').AsString := FieldByName('HIST01').AsString;

                  cdsConPag.Post;
                  blnGraDeb := True;
                  Inc(intPosDeb);
                End;
              End;

              If (Not blnGraDeb) Then
              Begin
                If ((intPosNov - 1) < RecordCount) Then
                  RecNo := RecNo - 1;
              End;

              blnGraDeb := False;
              blnGraCre := False;
              Next;
            End;
          End;

          qckRel.Script.Variables['PERIODO']:= mskMesBas.Text;
          If Assigned(qckRel.FindObject('Memo19')) Then
            TfrxMemoView(qckRel.FindObject('Memo19')).Memo.Text := mskMesBas.Text;
          cdsConPag.IndexFieldNames := 'FUN_NOMFUN;VER_CODVER';

          frxRelatorio.DataSet := cdsConPag;

          If (edtDestino.Text = 'E') Then //MF: 281249 - 04/05/2023
          Begin
              pCriarFormularios(TfrmGravando,frmGravando);
              Try
                frmGravando.fExecutarAcao := fEnviaRecibosEmailMensal;

                frmGravando.lblGravando.Caption := 'Aguarde... Enviando e-Mail...';
                thrSincEmail    := TThreadSincronizaEmails.Create;

                frmGravando.ShowModal;
              Finally
                pFreeAndNil(frmGravando);

                pPrintReportLogEmail;
              End;
          End
          Else
          Begin //MF: 281249 - 04/05/2023

            For AContador := 1 To StrToInt(edtQtdVia.Text) Do
            Begin
              If edtDestino.Text = 'V' Then
                pPreviewReport(Self.Name, Self.Caption, qckRel)
              Else If qckRel.PrepareReport Then
              begin
                qckRel.PrintOptions.ShowDialog := false;
                pPrintReport(Self.Name, Self.Caption, strNomImp, qckRel);
              end;
            end;

          End;

          FreeAndNil(qryCon);
          FreeAndNil(stlCodDeb);
          FreeAndNil(stlDesDeb);
          FreeAndNil(stlValDeb);
          cdsConPag.Close;
        End
        Else
          pTabelaVazia;
      end
      else
      begin
        {***********************}
        {* RECIBO PARA EVENTOS *}
        {********************RV*}
        cdsRecibo.CreateDataSet;

        if rdgTipoPesquisa.ItemIndex = 1 then
        begin
          TMonQdr.Create(Nil).AtualizaDadosDeVersoesAnteriores(edtCodEvento.Text, VS_strCodEmp);

          With frmModuloSPR.qryRelatorio Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(fRetSQLSelect(''));

            ParamByName('CODEMP').AsString := VS_strCodEmp;
            ParamByName('CODEVE').AsString := edtCodEvento.Text;
            If Not fEmptyStr(edtCodFun.Text) Then
              ParamByName('CODFUN').AsString := edtCodFun.Text;

            Open;
            {******************************************************}
            {* ALIMENTA O CDSRECIBO PARA IMPRESSÃO DOS RECIBOS    *}
            {***************************************************RV*}
            First;
            While Not Eof Do
            Begin
              For AContador := 1 To StrToInt(edtQtdVia.Text) Do
              Begin
                cdsRecibo.Append;
                cdsReciboNOMREC.AsString    := FieldByName('NOMFUN').AsString;
                cdsReciboVALREC.AsFloat     := FieldByName('VLRFUN').AsFloat;
                cdsReciboCPFFUN.AsString    := FieldByName('CPFFUN').AsString;
                cdsReciboDTAEVE.AsString    := FieldByName('DTAEVE').AsString;
                cdsReciboEMAIL_.AsString    := FieldByName('EMAIL_').AsString;
                cdsReciboCODFUN.AsString    := FieldByName('CODFUN').AsString;

                if not fEmptyStr(FieldByName('DTAEVE').AsString) then
                  cdsReciboDTAEVEINC.AsString := DateToStr(IncDay(FieldByName('DTAEVE').AsVariant,1));

                cdsReciboVLREXT.AsString    := UpperCase(fRetExtensoNumero(FieldByName('VLRFUN').AsString));
                cdsReciboHISREC.AsString    := edtDescricaoEvento.Text;
                cdsReciboDTAREC.AsString    := fRetDataExtenso(Date, True);
                cdsReciboNROVIA.AsInteger   := AContador;
                cdsRecibo.Post;
              End;
              Next;
            End;
          End;

          frxRelatorio.DataSet := cdsRecibo;

          If (cdsRecibo.RecordCount > 0) Then
          Begin
            {******************************************************}
            {* DEFINE SE O RELATORIO É MATRICIAL OU JATO DE TINTA *}
            {***************************************************RV*}
//            qryCfgRel := fCriaQuery(Self);
//            pCarregaConfImpr(qryCfgRel, Self.Name);                       /// JA FAZ ISSO NO ANCESTRAL
//            strNomImp := qryCfgRel.FieldByName('REL_NOMFIL').AsString;    /// JA FAZ ISSO NO ANCESTRAL
//            strTipImp := qryCfgRel.FieldByName('REL_IDEIMP').AsString;    /// JA FAZ ISSO NO ANCESTRAL

            {*****************************}
            {* CARREGA O LAYOUT DO BANCO *}
            {**************************LM*}
            If (strTipImp = 'M') Then
            begin
              pLoadReport(frxOSM_Evento, 'RECPFE', strTipImp);
              frxOSM_Evento.PrintOptions.Printer := strNomImp;
              qckRel := frxOSM_Evento
            end
            Else
            begin
              pLoadReport(frxOSJ_Evento, 'RECPFE', strTipImp);
              frxOSJ_Evento.PrintOptions.Printer := strNomImp;
              qckRel := frxOSJ_Evento;
            end;

            If (edtDestino.Text = 'E') Then //MF: 281249 - 05/05/2023
            Begin
                pCriarFormularios(TfrmGravando,frmGravando);
                Try
                  frmGravando.fExecutarAcao := fEnviaRecibosEmailEventos;

                  frmGravando.lblGravando.Caption := 'Aguarde... Enviando e-Mail...';
                  thrSincEmail    := TThreadSincronizaEmails.Create;



                  frmGravando.ShowModal;
                Finally
                  pFreeAndNil(frmGravando);

                  pPrintReportLogEmail;
                End;
            End
            Else
            Begin //MF: 281249 - 04/05/2023

              If (edtDestino.Text = 'V') Then
                pPreviewReport(Self.Name, Self.Caption, qckRel)

              Else If qckRel.PrepareReport Then
                pPrintReport(Self.Name, Self.Caption, strNomImp, qckRel);

            End;
          End
          Else
            pTabelaVazia;

          FreeAndNil(qryCon);
          FreeAndNil(stlCodDeb);
          FreeAndNil(stlDesDeb);
          FreeAndNil(stlValDeb);
          cdsRecibo.Close;
        end;
      end;

    Except
      On E: Exception Do
      Begin
        fMensagem('',E.Message,['&OK']);
      End;
    End;

    pSetFocus(edtCodEmpresa);
  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption     := '';

end;

procedure TfrmRelRecPagtoFunc.pCarregaEvento;
begin
  If Not fEmptyStr(edtCodEvento.Text) Then
    edtDescricaoEvento.Text := fRetNomEvento(edtCodEvento.Text)
  Else
    edtDescricaoEvento.Clear;
end;

procedure TfrmRelRecPagtoFunc.rdgTipoPesquisaClick(Sender: TObject);
begin
  inherited;
  if rdgTipoPEsquisa.ItemIndex = 0 then
  begin
    edtCodEvento.Clear;
    edtDescricaoEvento.Clear;
    edtCodEvento.Enabled := False;
    edtDescricaoEvento.Enabled := False;

    mskMesBas.Clear;
    edtTipMov.Clear;
    mskMesBas.Enabled := True;
    edtTipMov.Enabled := True;
  end
  else
  begin
    mskMesBas.Clear;
    edtTipMov.Clear;
    mskMesBas.Enabled := False;
    edtTipMov.Enabled := False;

    edtCodEvento.Clear;
    edtDescricaoEvento.Clear;
    edtCodEvento.Enabled := True;
  end;
end;

function TfrmRelRecPagtoFunc.fRetSQLSelect(strOpcSel: String): String;
Var
  strSQL: String;


  function fRetFunc(arrFuncionario: TConsultasArray; arrEmpresa: TConsultasArray = nil): string;
  var
    strSQL: String;
    intIndice: Integer;
  begin
     if not assigned(arrfuncAutIncrem) then
       strSQL := strSQl + 'AND CADFUN.FUN_CODFUN IN ('
     else
       strSQL := strSQl + 'AND CADFUN.AUTOINCREM IN (';
     for intIndice := low(arrFuncionario) to high(arrFuncionario) do
     begin
       if intIndice > low(arrFuncionario) then
         strSQL := strSQL + ',';
       strSQL := strSQL + arrFuncionario[intIndice].strCodigo;
     end;
     strSQL := strSQL + ')';

     if assigned(arrEmpresa) and (assigned(arrfuncAutIncrem)) then
     begin
         strSQL := strSQL + ' AND CADFUN.FUN_CODEMP IN ( ';
       for intIndice := low(arrEmpresa) to high(arrEmpresa) do
         strSQL := strSQL + iif(intIndice = low(arrEmpresa),'',',') + arrEmpresa[intIndice].strCodigo;
       strSQL := strSQL + ')';
     end;

     result := strSQL;
  end;

begin
  if rdgTipoPesquisa.ItemIndex = 0 then
  begin
    strSQL := '';
    strSQL := strSQL + 'SELECT   ';
    strSQL := strSQL + '  CONCAT(VER_CODVER, " - ", VER_DESVER) AS DESVER, ';
    strSQL := strSQL + '  CONCAT(PAG_CODFUN, " - ", FUN_NOMFUN) AS NOMFUN, ';
    strSQL := strSQL + '  CONCAT(BCO_CODBCO, " - ", BCO_NOMBCO) AS NUMBCO, ';
    strSQL := strSQL + '  PAG_CODVER     AS CODVER, ';
    strSQL := strSQL + '  PAG_VALLAN     AS VALLAN, ';
    strSQL := strSQL + '  PAG_CODFUN     AS CODFUN, ';
    strSQL := strSQL + '  VER_CODVER              , ';
    strSQL := strSQL + '  VER_DEBCRE     AS DEBCRE, ';
    strSQL := strSQL + '  VER_DESVER,               ';
    strSQL := strSQL + '  FUN_NOMFUN,               ';
    strSQL := strSQL + '  FUN_AGENCI     AS AGENCI, ';
    strSQL := strSQL + '  FUN_CONTA_     AS CONTA_, ';
    strSQL := strSQL + '  "   "          AS CODDEB, ';
    strSQL := strSQL + '  REPEAT(" ",30) AS DESDEB, ';
    strSQL := strSQL + '  0.00           AS VALDEB, ';
    strSQL := strSQL + '  EMP_NOMEMP,               ';
    strSQL := strSQL + '  EMP_ENDERE,               ';
    strSQL := strSQL + '  EMP_C_G_C_,               ';
    strSQL := strSQL + '  PAG_CODEMP AS CODEMP,     ';
    strSQL := strSQL + '  FUN_EMAIL_ AS EMAIL_,     ';//MF: 281249 - 04/05/2023
    strSQL := strSQL + '  PAG_AUTFUN AS AUTFUN,     ';
    strSQL := strSQL + '  CADPAG.CTP_HIST01 AS HIST01 ';

    strSQL := strSQL + 'FROM     ';
    strSQL := strSQL + '  CTRPAG ';
    strSQL := strSQL + '  LEFT JOIN CADFUN ON CADFUN.AUTOINCREM=PAG_AUTFUN ';
    strSQL := strSQL + '  LEFT JOIN CADVER ON VER_CODVER = PAG_CODVER     ';
    strSQL := strSQL + '  LEFT JOIN CADEMP ON EMP_CODEMP = PAG_CODEMP     '; // **
    strSQL := strSQL + '  LEFT JOIN CADBCO ON BCO_CODBCO = FUN_BANCO_     ';
    strSQL := strSQL + '  LEFT JOIN CADPAG ON CADPAG.AUTOINCREM  = PAG_AUTCTP ';
    strSQL := strSQL + 'WHERE                                             ';

    If (strOpcSel = 'C') Then
    Begin
      strSQL := strSQL + '  PAG_MESBAS = :MESBAS AND  ';
      strSQL := strSQL + '  PAG_TIPMOV = :TIPMOV   ';

      if not fEmptyStr(edtCodEmpresa.Text) then
      begin
        if length(arrEmpresa) > 1 then
          strSQL := strSQL + fStrlocate(edtCodEmpresa, arrEmpresa, 'PAG_CODEMP', 'CODEMP')
        else
          strSQL := strSQL + ' AND PAG_CODEMP = :CODEMP ';
      end;

      If Not fEmptyStr(edtCodFun.Text) Then
      begin
        if assigned(arrFuncionario) or (length(arrFuncionario) = 0 ) then
        begin
          strSQL := strSQL + fRetFunc(arrFuncionario, arrempresa);
        end
        else
          strSQL := strSQL + ' AND PAG_CODFUN = :CODFUN ';
      end;

      If Not fEmptyStr(edtCodVer.Text) Then
      begin
        if length(arrTipoVerba) > 1 then
          strSQL := strSQL + fStrLocate(edtCodVer, arrTipoVerba, 'PAG_CODVER', 'CODVER')
        else
          strSQL := strSQL + ' AND PAG_CODVER = :CODVER ';
      end;

      strSQL := strSQL + 'ORDER BY                    ';
      strSQL := strSQL + '  FUN_CODFUN,               ';
      strSQL := strSQL + '  VER_DEBCRE,               ';
      strSQL := strSQL + '  VER_CODVER                ';
    End
    Else
      strSQL := strSQL + '  FALSE ';
  end
  else if rdgTipoPesquisa.ItemIndex = 1 then
  begin
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  U.FUN_C_P_F_ AS CPFFUN,     ';
    strSQL := strSQL + '  E.EVE_DTAEVE AS DTAEVE,     ';
    strSQL := strSQL + '  E.EVE_DESEVE AS DESEVE,     ';
    strSQL := strSQL + '  D.DET_CODFUN AS CODFUN,     ';
    strSQL := strSQL + '  U.FUN_NOMFUN AS NOMFUN,     ';
    strSQL := strSQL + '  U.FUN_EMAIL_ AS EMAIL_,     ';//MF: 281249 - 04/05/2023
    strSQL := strSQL + '  SUM(D.DET_VLRFUN) AS VLRFUN ';
    strSQL := strSQL + 'FROM                          ';
    strSQL := strSQL + '  EVEDET D                    ';
    strSQL := strSQL + '  INNER JOIN CADFUN U ON (U.AUTOINCREM = D.DET_AUTFUN) ';
    strSQL := strSQL + '  INNER JOIN CADEVE E ON E.EVE_CODEVE = D.DET_CODEVE ';
    strSQL := strSQL + 'WHERE                         ';
    strSQL := strSQL + '  D.DET_CODEMP = :CODEMP AND  ';
    strSQL := strSQL + '  D.DET_CODEVE = :CODEVE      ';
    If Not fEmptyStr(edtCodFun.Text) Then
      strSQL := strSQL + '  AND D.DET_CODFUN = :CODFUN ';
    strSQL := strSQL + 'GROUP BY      ';
    strSQL := strSQL + '  DET_CODEVE, ';
    strSQL := strSQL + '  DET_AUTFUN  ';
    strSQL := strSQL + 'ORDER BY      ';
    strSQL := strSQL + '  FUN_NOMFUN  ';
  end;

  Result := strSQL;
end;

procedure TfrmRelRecPagtoFunc.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmpresa, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmRelRecPagtoFunc.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmpresa,false) Then
  Begin
    If fValidaCampos(TEditFocus(Sender), True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelRecPagtoFunc.edtCodEventoExit(Sender: TObject);
begin
  inherited;
  If not (fEmptyStr(edtCodEvento.Text)) Then
    pEdtCodSelectExit(edtCodEvento, edtDescricaoEvento, arrEvento, fRetNomEvento, Nil, 'do Evento')
  else
    edtDescricaoEvento.Clear;
end;

procedure TfrmRelRecPagtoFunc.edtCodEventoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEventos(Self, edtCodEvento, edtDescricaoEvento, Nil, Key, arrEvento) Then
  Begin
    If fValidaCampos(edtCodEvento, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelRecPagtoFunc.edtCodFunExit(Sender: TObject);
begin
  inherited;
  if not assigned(arrfuncAutIncrem) then
    pEdtCodSelectExit(edtCodFun, edtDesFun, arrFuncionario, nil, fRetNomFun, 'do funcionário',0,false,'Código',false,false,fRetNomFunc,arrEmpresa,iif(edtDesEmpresa.text <> '+1',edtCodEmpresa.text,''));
end;

procedure TfrmRelRecPagtoFunc.edtCodFunKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key <> #13 then
    arrfuncAutIncrem := nil;
  inherited;
  if fPesqFuncionarios(Self, edtCodFun, edtDesFun, nil, Key, arrFuncionario, False, arrEmpresa) then
  Begin
    if fValidaCampos(edtCodFun, False) then
    begin
      arrfuncAutIncrem := arrFuncionario;
      SelectNext(ActiveControl, True, True);
    end;
  End;

end;

procedure TfrmRelRecPagtoFunc.edtCodVerExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodVer, edtDesVer, arrTipoVerba, Nil, fRetDescVerba, 'do Tipo Verba');
end;

procedure TfrmRelRecPagtoFunc.edtCodVerKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqVerbas(Self, edtCodVer, edtDesVer, nil, Key, arrTipoVerba) Then
  Begin
    If fValidaCampos(edtCodVer, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelRecPagtoFunc.edtDestinoExit(Sender: TObject);
begin
  If fEmptyStr(edtDestino.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser preenchido!', ['&Ok']);
    pSetFocus(edtDestino);
  End
  Else If Pos(edtDestino.Text, 'VIE') <= 0 Then
  Begin

    fMensagem('ATENÇÃO', 'O Destino do Relatório deve ser V, I ou E!', ['&Ok']);

    pSetFocus(edtDestino);
  End;
end;

procedure TfrmRelRecPagtoFunc.FormCreate(Sender: TObject);
begin
  inherited;
  FPais := fSetaPais;
end;

procedure TfrmRelRecPagtoFunc.FormShow(Sender: TObject);
begin
  inherited;
  edtCodEmpresa.Text := VS_strCodEmp;
  edtDesEmpresa.Text := fRetNomeEmpresa;

  edtCodEvento.Clear;
  edtDescricaoEvento.Clear;
  edtCodEvento.Enabled := False;
  edtDescricaoEvento.Enabled := False;

  mskMesBas.Clear;
  edtTipMov.Clear;
  mskMesBas.Enabled := True;

  if not fCfgSis('EVEDTQ', varBoolean) then
  begin
    rdgTipoPesquisa.Enabled := False;
    pSetFocus(edtCodEmpresa);
  end;

  TfrmGravando.fExecutarModal(TCadFun.CriaNovosRegistrosDeFuncoes, 'Aguarde... Atualizando registros de versões  anteriores.', '');
  If TCadFun.ExistemFuncoesCadastradasNaFormaAntiga Then
    TfrmGravando.fExecutarModal(TCadFun.CorrigeCadastroDeFuncoes, 'Aguarde... Atualizando registros de versões anteriores.', '');
end;

function TfrmRelRecPagtoFunc.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    If (Sender = mskMesBas) Then
    Begin
      If (rdgTipopesquisa.ItemIndex = 0) then
      begin
        if (fEmptyStr(fTiraCaracEspeciais(mskMesBas.Text))) Then
        Begin
          fMensagem('ATENÇÃO!','O Mês Base deve ser preenchido!',['&Ok']);
          Result := False;
        End
        Else
        If (strToInt(Trim(LeftStr(mskMesBas.Text,2))) > 12) Or (strToInt(Trim(LeftStr(mskMesBas.Text,2))) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!','O Mês informado é inválido!',['&Ok']);
          Result := False;
        End
        Else If (strToInt(Trim(RightStr(mskMesBas.Text,4))) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!','O Ano informado é inválido!',['&O k']);
          Result := False;
        End;
      end;
    End
    Else If (Sender = edtCodFun) Then
    Begin
      if fEmptyStr(edtCodFun.text) then
        pDesmarcaLista(edtCodFun, arrFuncionario);
    End
    Else If (Sender = edtCodVer) Then
    Begin
      pDesmarcaLista(edtCodVer, arrTipoVerba);
    End
    Else If (Sender = edtCodEvento) then
    begin
      If (rdgTipopesquisa.ItemIndex = 1) then
      begin
        If (fEmptyStr(edtCodEvento.Text)) Then
        Begin
          fMensagem('ATENÇÃO!','O Evento deve ser preenchido!',['&Ok']);
          Result := False;
        end
        else If Not SameText(edtCodEvento.Text, '00000') Then
        Begin
          SetLength(arrEvento, 0);

          pCarregaEvento;
          If fEmptyStr(edtDescricaoEvento.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Evento não está cadastrado!', ['&O k']);
            Result := False;
          End;
        end;
      end;
    end;
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

procedure TfrmRelRecPagtoFunc.mskMesBasExit(Sender: TObject);
Var
  strTmp : String;
  dtaTmp : TDate;
begin
  inherited;
  If Not fEmptyStr(fTiraCaracEspeciais(mskMesBas.Text)) Then
  Begin
    strTmp := Copy(mskMesBas.Text, 4, Length(mskMesBas.Text));
    dtaTmp := StrToDate('01/01/'+strTmp);
    mskMesBas.Text := Copy(mskMesBas.Text, 1, 3) + FormatDateTime('yyyy', dtaTmp);
  End;
end;

end.


