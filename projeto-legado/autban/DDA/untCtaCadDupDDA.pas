unit untCtaCadDupDDA;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel,
  cxGrid, EditFocus, Uni, UniDataSetProvider, untFuncoesSimples, untConstantes,
  UniClientDataset, StrUtils, untConsultas, untPesqAux, untTypesSistema, cxProgressBar,
  untCadPag, untFuncoesBoleto, untFuncAutBan, untFuncoes,
  cxLookAndFeelPainters, cxStyles, untZClient,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxCurrencyEdit,
  cxContainer, Vcl.ComCtrls, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxButtonEdit, cxBlobEdit, dxScreenTip,
  dxCustomHint, cxHint, cxLocalization, cxMemo;

type
  TfrmCtaCadDupDDA = class(TfrmPai)
    BtnMarcarTodas: TBitBtnLocked;
    btnDesmarcarTodas: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    pnlAux2: TPanel;
    pnlTotais: TPanel;
    grdDuplic: TcxGridCitel;
    grdDuplicDados: TcxGridDBTableViewCitel;
    grdDuplicDadosDDA_NUMDUP: TcxGridDBColumn;
    grdDuplicDadosPARCEL: TcxGridDBColumn;
    grdDuplicDadosDDA_CODEMP: TcxGridDBColumn;
    grdDuplicDadosDDA_DTAVEN: TcxGridDBColumn;
    grdDuplicDadosDDA_VALTIT: TcxGridDBColumn;
    grdDuplicDadosMARDES: TcxGridDBColumn;
    grdDuplicNivel: TcxGridLevel;
    rdgFiltrar: TRadioGroup;
    grdDuplicDadosFOR_CODCTA: TcxGridDBColumn;
    grdDuplicDadosFORNECEDOR: TcxGridDBColumn;
    grdDuplicDadosPORTADOR: TcxGridDBColumn;
    grdDuplicDadosEVENTO: TcxGridDBColumn;
    grdDuplicDadosHISTORICO: TcxGridDBColumn;
    grdDuplicDadosDDA_DTAEMI: TcxGridDBColumn;
    grdDuplicDadosDDA_CODFOR: TcxGridDBColumn;
    Panel1: TPanel;
    grdDuplicDadosVEIOBO: TcxGridDBColumn;
    grdDuplicDadosVEIONF: TcxGridDBColumn;
    grdDuplicDadosUSACHQ: TcxGridDBColumn;
    grdDuplicDadosPREVIS: TcxGridDBColumn;
    grdDuplicDadosDEPOSI: TcxGridDBColumn;
    Panel2: TPanel;
    pnlCamposTotais: TPanel;
    edtTotalSelecionado: TEditFocus;
    edtTotalDup: TEditFocus;
    Label9: TLabel;
    Label21: TLabel;
    gpbLegenda: TGroupBox;
    shp1: TShape;
    lbl1: TLabel;
    lbl3: TLabel;
    Label1: TLabel;
    Shape1: TShape;
    Label2: TLabel;
    Label3: TLabel;
    Shape2: TShape;
    Label4: TLabel;
    Label17: TLabel;
    edtQtdDup: TEditFocus;
    edtSelDup: TEditFocus;
    Label18: TLabel;
    grdDuplicDadosCTP_NUMDUP: TcxGridDBColumn;
    grdDuplicDadosFOR_CODFOR: TcxGridDBColumn;
    btnBaixarDDA: TBitBtnLocked;
    Label5: TLabel;
    Label11: TLabel;
    rdgFiltroData: TRadioGroup;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    btnConsultar: TBitBtnLocked;
    grdDuplicDadosACAO: TcxGridDBColumn;
    grdDuplicDadosCEDENTE: TcxGridDBColumn;
    btnGeraCSV: TBitBtnLocked;
    grdDuplicDadosATUALIZAHISTORICO: TcxGridDBColumn;
    HintControler: TcxHintStyleController;
    grdDuplicDadosEMP_NOMEMP: TcxGridDBColumn;
    Label6: TLabel;
    Shape3: TShape;
    Label7: TLabel;
    grdDuplicDadosDDA_CNPJ_: TcxGridDBColumn;
    grdDuplicDadosFOR_C_G_C_: TcxGridDBColumn;
    lcl: TcxLocalizer;
    grpDataArquivos: TGroupBox;
    edtDataInicial: TcxDateEdit;
    btnReprocessar: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdDuplicDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure BtnMarcarTodasClick(Sender: TObject);
    procedure btnDesmarcarTodasClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure grdDuplicDadosDblClick(Sender: TObject);
    procedure grdDuplicDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure btnBaixarDDAClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure grdDuplicDadosDEPOSIGetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure grdDuplicDadosFORNECEDORPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure btnReprocessarClick(Sender: TObject);
    procedure btnGeraCSVClick(Sender: TObject);
    procedure grdDuplicDadosHISTORICOGetCellHint(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; ACellViewInfo: TcxGridTableDataCellViewInfo;
      const AMousePos: TPoint; var AHintText: TCaption;
      var AIsHintMultiLine: Boolean; var AHintTextRect: TRect);
    procedure grdDuplicDadosHISTORICOGetPropertiesForEdit(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    procedure grdDuplicDadosATUALIZAHISTORICOPropertiesCloseUp(Sender: TObject);
  private
    FstrConfig : String;

    cdsSelDup  : TZClient;

    blnMarcarT : Boolean;
    blnConfirma: Boolean;
    blnComDiv  : Boolean;

    FDataInicial: TDateTime;

    procedure pCriaTemporaria;
    procedure pAtualizaTemporaria;
    procedure pAtualizarParcelas;
    function fAtualizarParcelas(pgbProgresso: TcxProgressBar): Boolean;

    procedure pSelecionaDuplicata;
    function DesmarcarDuplicata: Boolean;

    procedure pCriaAgrFields;

    procedure pStep(pgbStatus: TcxProgressBar);

    function fMarcarTodas(pgbStatus: TcxProgressBar): Boolean;
    function fMarcarTodasBaixaManual(pgbStatus: TcxProgressBar): Boolean;
    function fDesmarcarTodas(pgbStatus: TcxProgressBar): Boolean;
    function fCadastrarCtp(pgbStatus: TcxProgressBar): Boolean;
    function fAtualizaDupDDA: Boolean;
    function fAtualizaDDA: Boolean;
    function fUltimaParcela(strNumDup,
                            strCodEmp,
                            strCodFor: String): Integer;

    procedure AtualizaFornecedoresSelecionados;
    procedure MarcarTodasParaCadastrar;
    procedure MarcarTodasParaBaixaManual;

    procedure pGeraCsv;
    procedure pAtualizaHistorico;

    function fVerificaDiv: Boolean;
    { Private declarations }
  public
    property strConfig: String read FstrConfig write FstrConfig;
    { Public declarations }
  end;

var
  frmCtaCadDupDDA: TfrmCtaCadDupDDA;

implementation

{$R *.dfm}

uses untGravando, untCtaDigDadosDDA, untLogCtp,
     untTraducaoCxCompsAutBan, cxGridExportLink, untCtaSelecionaDuplicataDDA;

procedure TfrmCtaCadDupDDA.pStep(pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

function TfrmCtaCadDupDDA.fMarcarTodas(pgbStatus: TcxProgressBar): Boolean;
Var prcScroll: TprcScroll;
    blnSemFor: Boolean;
begin
  Result := True;
  blnSemFor := False;

  Try
    blnMarcarT := True;
    pDisableControls(cdsSelDup, prcScroll);

    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := cdsSelDup.RecordCount;

    cdsSelDup.First;
    While Not cdsSelDup.Eof Do
    Begin
      pStep(pgbStatus);
      Try
        If fEmptyStr(cdsSelDup.FieldByName('FOR_CODFOR').AsString) Then
          blnSemFor := True
        Else If fEmptyStr(cdsSelDup.FieldByName('FOR_CODCTA').AsString) Then
          blnSemFor := True
        Else If (cdsSelDup.FieldByName('MARDES').AsString <> 'M') Then
          pSelecionaDuplicata;
      Except
        On E: Exception Do
        Begin
          Result := False;
          fMensagem('','Ocorreu um erro ao marcar o registro para cadastro!' + #13 + E.Message,['&OK']);
          Break;
        End;
      End;
      cdsSelDup.Next;
    End;
  Finally
    blnMarcarT := False;
    cdsSelDup.First;
    pEnableControls(cdsSelDup, prcScroll);

    If blnSemFor Then
      pMensagemOK('Alguns documentos não foram selecionados, pois não possuem Fornecedor ou Plano de Contas vinculado.');
  End;

  pAtualizaTemporaria;
end;

function TfrmCtaCadDupDDA.fMarcarTodasBaixaManual(
  pgbStatus: TcxProgressBar): Boolean;
var
  prcScroll: TprcScroll;
begin
  Result := True;

  Try
    pDisableControls(cdsSelDup, prcScroll);

    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := cdsSelDup.RecordCount;

    cdsSelDup.First;
    While Not cdsSelDup.Eof Do
    Begin
      pStep(pgbStatus);
      Try

        If cdsSelDup.FieldByName('MARDES').AsString <> 'M' Then
        begin
          cdsSelDup.Edit;

          cdsSelDup.FieldByName('ACAO').AsString := 'Baixa Manual';
          cdsSelDup.FieldByName('MARDES').AsString := 'M';
          cdsSelDup.FieldByName('TOTSEL').Value    := cdsSelDup.FieldByName('DDA_VALTIT').Value;
          cdsSelDup.FieldByName('QTDSEL').Value    := 1;

          cdsSelDup.Post;
        End;

      Except
        On E: Exception Do
        Begin
          Result := False;
          fMensagem('','Ocorreu um erro ao marcar o registro para Baixa Manual!' + #13 + E.Message,['&OK']);
          Break;
        End;
      End;
      cdsSelDup.Next;
    End;
  Finally;
    cdsSelDup.First;
    pEnableControls(cdsSelDup, prcScroll);
  End;
  pAtualizaTemporaria;
end;

function TfrmCtaCadDupDDA.fAtualizaDDA: Boolean;
  const
  SQL_UPDATE =
    ' UPDATE RETDDA' +
    ' SET ' +
    '   DDA_OPEBAI = :OPEBAI,' +
    '   DDA_DTABAI = :DTABAI,' +
    '   DDA_HORBAI = :HRABAI,' +
    '   DDA_TIPBAI = :TIPBAI,' +
    '   DDA_AUTCTP = :AUTCTP,' +
    '   DDA_HIST01 = :HIST01'  +
    ' WHERE DDA_CODBCO = :CODBCO' +
    '   AND DDA_BCOCOM = :BCOCOM' +
    '   AND DDA_CODEMP = :CODEMP' +
    '   AND DDA_NUMDUP = :NUMDUP' +
    '   AND DDA_CODFOR = :CODFOR' +
    '   AND DDA_DTAVEN = :DTAVEN' +
    '   AND DDA_VALTIT = :VALTIT';

Var
  qryUpdDDA: TUniQuery;

begin
  Result :=True;
  Application.ProcessMessages;

  Try
    qryUpdDDA := fCriaQuery(Nil);

    qryUpdDDA.Close;
    qryUpdDDA.SQL.Clear;
    qryUpdDDA.SQL.Add(SQL_UPDATE);

    If Not cdsSelDup.FieldByName('DDA_CODFOR').AsString.IsEmpty Then
      qryUpdDDA.ParamByName('CODFOR').AsString   := cdsSelDup.FieldByName('DDA_CODFOR').AsString
    Else
    Begin
      qryUpdDDA.SQL.Text := qryUpdDDA.SQL.Text.Replace('DDA_CODFOR = :CODFOR', 'DDA_CNPJ__ = :CNPJ__');
      qryUpdDDA.ParamByName('CNPJ__').AsString   := cdsSelDup.FieldByName('DDA_CNPJ__').AsString;
    End;

    qryUpdDDA.ParamByName('OPEBAI').AsString := strLoginUsuarioLogado;
    qryUpdDDA.ParamByName('DTABAI').AsDateTime := VS_DATE;
    qryUpdDDA.ParamByName('HRABAI').AsDateTime := fTime();
    qryUpdDDA.ParamByName('TIPBAI').AsString := cdsSelDup.FieldByName('ACAO').AsString;

    if not fEmptyStr(cdsSelDup.FieldByName('DDA_AUTCTP').AsString) then
      qryUpdDDA.ParamByName('AUTCTP').AsString := cdsSelDup.FieldByName('DDA_AUTCTP').AsString
    else
      qryUpdDDA.ParamByName('AUTCTP').Value := Null;

    qryUpdDDA.ParamByName('CODBCO').AsString   := cdsSelDup.FieldByName('DDA_CODBCO').AsString;
    qryUpdDDA.ParamByName('BCOCOM').AsString   := cdsSelDup.FieldByName('DDA_BCOCOM').AsString;
    qryUpdDDA.ParamByName('NUMDUP').AsString   := cdsSelDup.FieldByName('DDA_NUMDUP').AsString;

    qryUpdDDA.ParamByName('CODEMP').AsString   := cdsSelDup.FieldByName('DDA_CODEMP').AsString;
    qryUpdDDA.ParamByName('DTAVEN').AsDateTime := cdsSelDup.FieldByName('DDA_DTAVEN').AsDateTime;
    qryUpdDDA.ParamByName('VALTIT').Value      := cdsSelDup.FieldByName('DDA_VALTIT').Value;
    qryUpdDDA.ParamByName('HIST01').AsString   := cdsSelDup.FieldByName('DDA_HIST01').AsString;

    qryUpdDDA.ExecSQL;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TfrmCtaCadDupDDA.fAtualizaDDA');
    End;
  End;

  qryUpdDDA.Close;
  FreeAndNil(qryUpdDDA);
end;

function TfrmCtaCadDupDDA.fAtualizaDupDDA: Boolean;
  Var
    qryUpdDDA: TUniQuery;
    strSQL   : String;
begin
  Result := True;
  strSQL := '';

  strSQL := strSQL + ' UPDATE CADPAG SET CTP_LINDIG = :LINDIG, CTP_CODBAR = :CODBAR ';
  strSQL := strSQL + ' WHERE AUTOINCREM = :AUTINC ';

  Application.ProcessMessages;

  Try
    qryUpdDDA := fCriaQuery(Nil);
    qryUpdDDA.Close;
    qryUpdDDA.SQL.Clear;
    qryUpdDDA.SQL.Add(strSQL);

    qryUpdDDA.ParamByName('AUTINC').AsString   := cdsSelDup.FieldByName('DDA_AUTCTP').AsString;
    qryUpdDDA.ParamByName('CODBAR').AsString   := cdsSelDup.FieldByName('DDA_CODBAR').AsString;
    qryUpdDDA.ParamByName('LINDIG').AsString   := cdsSelDup.FieldByName('DDA_LINDIG').AsString;

    qryUpdDDA.ExecSQL;
  Except
     On E: Exception Do
     Begin
       Result := False;
       pMensagensErro(E.Message,'');
     End;
  End;
  qryUpdDDA.Close;
  FreeAndNil(qryUpdDDA);
end;

function TfrmCtaCadDupDDA.fCadastrarCtp(pgbStatus: TcxProgressBar): Boolean;
  Var
    prcScroll: TprcScroll;

    LAutoIncremCadPag: String;
begin
  Result := True;
  pDisableControls(cdsSelDup, prcScroll);

  fStartTransaction;
  Try
    Try
      cdsSelDup.Filter := 'MARDES=' + QuotedStr('M');
      cdsSelDup.Filtered := True;

      pgbStatus.Position := 0;
      pgbStatus.Properties.Max := cdsSelDup.RecordCount;
      blnConfirma := False;

      cdsSelDup.First;

      While (Not cdsSelDup.Eof) Do
      Begin
        pStep(pgbStatus);

        if cdsSelDup.FieldByName('ACAO').AsString = 'Cadastrar' then
        begin
          LAutoIncremCadPag := fRetAutoIncrem('CADPAG', cdsSelDup.FieldByName('DDA_CODEMP').AsString);

          {******************************}
          {* INCLUI DUPLICATA NA CADPAG *}
          {***************************AJ*}
          blnConfirma := fGravaCadPag('frmCtaCadDupDDA',
                                      'INCLUSÃO DE DUPLICATA AUTOMÁTICA - DDA',
                                      cdsSelDup.FieldByName('FOR_CODFOR').AsString,
                                      cdsSelDup.FieldByName('DDA_DUPCOR').AsString,
                                      cdsSelDup.FieldByName('PARCEL').AsString,
                                      cdsSelDup.FieldByName('DDA_CODEMP').AsString,
                                      cdsSelDup.FieldByName('FOR_CODCTA').AsString,
                                      '',
                                      0,
                                      cdsSelDup.FieldByName('DDA_DTAEMI').AsDateTime,
                                      cdsSelDup.FieldByName('DDA_DTAVEN').AsDateTime,
                                      cdsSelDup.FieldByName('DDA_VALTIT').AsFloat,
                                      cdsSelDup.FieldByName('DDA_VALTIT').AsFloat,
                                      cdsSelDup.FieldByName('PREVIS').AsString,
                                      cdsSelDup.FieldByName('VEIOBO').AsString,
                                      cdsSelDup.FieldByName('DEPOSI').AsString,
                                      cdsSelDup.FieldByName('DDA_HIST01').AsString,
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      0,
                                      0,
                                      0,
                                      0,
                                      VS_strCodEmp,
                                      cdsSelDup.FieldByName('EVENTO').AsString,
                                      cdsSelDup.FieldByName('USACHQ').AsString,
                                      cdsSelDup.FieldByName('PORTADOR').AsString,
                                      '',
                                      0,
                                      0,
                                      0,
                                      False,
                                      0,
                                      '1',
                                      0,
                                      cdsSelDup.FieldByName('VEIONF').AsString,
                                      '',
                                      '',
                                      '',
                                      LAutoIncremCadPag,
                                      '',
                                      '',
                                      '',
                                      '',
                                      'N',
                                      '',
                                      '',
                                      '',
                                      '',
                                      '',
                                      0,
                                      0,
                                      0,
                                      0,
                                      '',
                                      0,
                                      0,
                                      cdsSelDup.FieldByName('DDA_LINDIG').AsString,
                                      cdsSelDup.FieldByName('DDA_CODBAR').AsString,
                                      '',
                                      '',
                                      '',
                                      '0',
                                      '',
                                      '',
                                      '',
                                      '',
                                      cdsSelDup.FieldByName('CTP_PAGANT').AsString);

          If blnConfirma Then
          Begin
            cdsSelDup.Edit;
            cdsSelDup.FieldByName('DDA_AUTCTP').AsString := LAutoIncremCadPag;
            cdsSelDup.Post;
          End;
        end
        Else if cdsSelDup.FieldByName('ACAO').AsString = 'Vincular' then
        begin
          blnConfirma := fAtualizaDupDDA;

          If blnConfirma Then
            untLogCtp.GravaLogCtp(cdsSelDup.FieldByName('DDA_AUTCTP').AsString,
                                  'ATUALIZAÇÃO DA LINHA DIGITÁVEL E CÓDIGO DE BARRAS - DDA',
                                  'frmCtaCadDupDDA');
        end
        else
          blnConfirma := fAtualizaDDA;

        If blnConfirma And MatchStr(cdsSelDup.FieldByName('ACAO').AsString, ['Cadastrar', 'Vincular']) Then
          blnConfirma := fAtualizaDDA;

        If Not blnConfirma Then
          Break;

        cdsSelDup.Next;
      End;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        blnConfirma := False;
        fMensagem('','Ocorreu um erro ao atualizar as duplicatas!' + #13 + E.Message,['&OK']);
        Exit(False);
      End;
    End;

    If blnConfirma Then
    begin
      fCommit;
      Result := True;
    end
    Else
    Begin
      fRollBack;
      Result := False;
    End;
  Finally
    pEnableControls(cdsSelDup, prcScroll);
    TfrmGravando.fExecutarModal(pCriaTemporaria, 'Aguarde... Selecionando Duplicatas.', '');
    pAtualizaTemporaria;
  End;
end;

function TfrmCtaCadDupDDA.fDesmarcarTodas(pgbStatus: TcxProgressBar): Boolean;
Var prcScroll: TprcScroll;
begin
  Result := True;

  Try
    blnMarcarT := True;
    pDisableControls(cdsSelDup, prcScroll);
    cdsSelDup.First;

    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := cdsSelDup.RecordCount;

    While Not cdsSelDup.Eof Do
    Begin
      pStep(pgbStatus);
      Try
        If (cdsSelDup.FieldByName('MARDES').AsString = 'M') Then
          pSelecionaDuplicata;
      Except
        On E: Exception Do
        Begin
          Result := False;
          fMensagem('','Ocorreu um erro ao Desmarcar o Registro para Atualização !' + #13 + E.Message,['&OK']);
          Break;
        End;
      End;
      cdsSelDup.Next;
    End;
  Finally
    blnMarcarT := False;
    cdsSelDup.First;
    pEnableControls(cdsSelDup, prcScroll);
  End;

  pAtualizaTemporaria;
end;

procedure TfrmCtaCadDupDDA.AtualizaFornecedoresSelecionados;
  Var
    LFiltroAnterior: String;
begin
  LFiltroAnterior := cdsSelDup.Filter;

  Try
    cdsSelDup.Filter := 'ALTFOR = ' + QuotedStr('S');
    cdsSelDup.Filtered := True;

    fStartTransaction;

    Try
      While Not cdsSelDup.Eof Do
      Begin

        If fEmptyStr(cdsSelDup.FieldByName('FORNECEDOR').AsString) Then
          fExecutaSQL('UPDATE RETDDA SET DDA_CODFOR = NULL, ' +
                      '                  DDA_CODFIL = NULL, ' +
                      '                  DDA_CNPJ__ = NULL  ' +
                      'WHERE DDA_CODBCO="' + cdsSelDup.FieldByName('DDA_CODBCO').AsString + '" ' +
                      '  AND DDA_LINDIG="' + cdsSelDup.FieldByName('DDA_LINDIG').AsString + '"')
        Else
          fExecutaSQL('UPDATE RETDDA SET DDA_CODFOR="' + LeftStr(cdsSelDup.FieldByName('FORNECEDOR').AsString, 8) + '", ' +
                      '                  DDA_CODFIL="' + LeftStr(cdsSelDup.FieldByName('FORNECEDOR').AsString, 8) + '_", ' +
                      '                  DDA_CNPJ__="' + cdsSelDup.FieldByName('FOR_C_G_C_').AsString + '" ' +
                      'WHERE DDA_CODBCO="' + cdsSelDup.FieldByName('DDA_CODBCO').AsString + '" ' +
                      '  AND DDA_LINDIG="' + cdsSelDup.FieldByName('DDA_LINDIG').AsString + '"');

        cdsSelDup.Next;
      End;

      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;

        pMensagensErro('Ocorreu um erro ao reprocessar as duplicatas.' + #13 +
                       'Erro gerado: ' + E.Message, '[TfrmCtaCadDupDDA.AtualizaFornecedoresSelecionados');
      End;
    End;

  Finally
    cdsSelDup.Filter   := LFiltroAnterior;
    cdsSelDup.Filtered := Not cdsSelDup.Filter.IsEmpty;
  End;
end;

procedure TfrmCtaCadDupDDA.btnApagarClick(Sender: TObject);
begin
  inherited;
  If (Not cdsSelDup.Active) Or (cdsSelDup.IsEmpty) Then
  Begin
    fMensagem('', 'É necessário ter registros para apagar!', ['&Ok']);
    Exit;
  End;

  If (fMensagem('', 'Confirma apagar a duplicata selecionada?', ['&Sim', '&Não']) = 2) Then
    Exit;

end;

procedure TfrmCtaCadDupDDA.btnBaixarDDAClick(Sender: TObject);
begin
  inherited;
  if cdsSelDup.IsEmpty then
  begin
    fMensagem('', 'Sem duplicatas para baixa direta!', ['&Ok']);

    Exit;
  end;

  If cdsSelDup.FieldByName('MARDES').AsString <> 'M' Then
  begin
    if (fMensagem('', 'Confirma baixa manual da duplicata nas rotinas do DDA? ' + #13 + #13 +
                      ' Duplicata deixará de ser listada nas rotinas do DDA e em caso de estar '  + #13 +
                      ' pendente no banco, a linha dígitavel/código de barras deve ser informada ' + #13+
                      ' direto no manutenção do contas a pagar ou a baixa, no banco, deverá  ' + #13 +
                      ' ocorrer de forma manual.', ['&Sim', '&Não'], 2, True, 1, 0, False, 0, False, False, False, 230) = 1) then
    begin
      cdsSelDup.Edit;

      cdsSelDup.FieldByName('ACAO').AsString := 'Baixa Manual';
      cdsSelDup.FieldByName('MARDES').AsString := 'M';
      cdsSelDup.FieldByName('TOTSEL').Value    := cdsSelDup.FieldByName('DDA_VALTIT').Value;
      cdsSelDup.FieldByName('QTDSEL').Value    := 1;

      cdsSelDup.Post;

      pAtualizaTemporaria;
    end;
  end
  Else
    fMensagem('', 'A duplicata não pode estar marcada!', ['&Ok']);
end;

procedure TfrmCtaCadDupDDA.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If Not btnConfirma.Enabled Then
    Exit;

  If (Not cdsSelDup.Active) Or (cdsSelDup.IsEmpty) Then
  Begin
    fMensagem('', 'É necessário ter registros para processar!', ['&Ok']);
    Exit;
  End;

  //Verifica se possui alguma duplicata selecionada no filtro atual
  If Not cdsSelDup.Locate('MARDES', 'M', []) Then
  Begin
    pMensagemOK('Não existem duplicatas marcadas no filtro para processar!');
    Exit;
  End;

  If (fMensagem('', 'Deseja realmente processar todas as duplicatas selecionadas?', ['&Sim', '&Não']) = 2) Then
    Exit;

  pnlBotoes.Enabled := False;
  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fCadastrarCtp;
  frmGravando.lblGravando.Caption := 'Aguarde... processando Duplicatas.';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
  pnlBotoes.Enabled := True;

  If blnConfirma Then
    pMensagemOK('Duplicatas processadas com sucesso!');
end;

procedure TfrmCtaCadDupDDA.btnConsultarClick(Sender: TObject);
  var
    strFiltroData,
    strFiltroForn,
    strFiltro: String;
begin
  inherited;
  strFiltro := '';
  strFiltroData := '';
  strFiltroForn := '';

  If rdgFiltroData.ItemIndex = 1 Then
    strFiltroData := ' DDA_DTAEMI >= ' + QuotedStr(FormatDatetime('dd/mm/yyyy', mskDtaIni.Date)) + ' AND  DDA_DTAEMI <= ' + QuotedStr(FormatDatetime('dd/mm/yyyy', mskDtaFin.Date))
  Else If rdgFiltroData.ItemIndex = 2 Then
    strFiltroData := ' DDA_DTAVEN >= ' + QuotedStr(FormatDatetime('dd/mm/yyyy', mskDtaIni.Date)) + ' AND  DDA_DTAVEN <= ' + QuotedStr(FormatDatetime('dd/mm/yyyy', mskDtaFin.Date))
  Else
    strFiltroData := '';

  If rdgFiltrar.ItemIndex = 0 Then
    strFiltroForn := strFiltro + ' FOR_CODFOR <>' + QuotedStr('') + ' AND FOR_CODFOR IS NOT NULL'
  Else If rdgFiltrar.ItemIndex = 1 Then
    strFiltroForn := strFiltro + ' FOR_CODFOR =' + QuotedStr('') + ' OR FOR_CODFOR IS NULL'
  Else
    strFiltroForn := strFiltro + '';

  if not fEmptyStr(strFiltroData)  then
    strFiltro  := strFiltroData;

  if ((not fEmptyStr(strFiltroForn)) and (not fEmptyStr(strFiltro))) then
    strFiltro := strFiltro + ' AND ' + strFiltroForn
  else
    strFiltro := strFiltro + strFiltroForn;

  if cdsSelDup.Active then
  begin
    cdsSelDup.Filter := strFiltro;

    cdsSelDup.Filtered := Not fEmptyStr(cdsSelDup.Filter);

    pAtualizaTemporaria;

    cdsSelDup.EnableControls;
  end;
end;

procedure TfrmCtaCadDupDDA.btnDesmarcarTodasClick(Sender: TObject);
begin
  inherited;
  If (Not cdsSelDup.Active) Or (cdsSelDup.IsEmpty) Then
  Begin
    fMensagem('', 'É necessário ter registros para marcar!', ['&Ok']);
    Exit;
  End;

  If rdgFiltrar.ItemIndex = 1 Then
  Begin
    fMensagem('ATENÇÃO', 'Não é possível marcar/desmarcar duplicatas sem fornecedor vinculado!', ['&Ok']);
    Exit;
  End;

  If (fMensagem('', 'Confirma desmarcar todas as duplicatas?', ['&Sim', '&Não']) = 2) Then
    Exit;

  pnlBotoes.Enabled := False;
  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fDesmarcarTodas;
  frmGravando.lblGravando.Caption := 'Aguarde... Desmarcando Duplicatas.';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
  pnlBotoes.Enabled := True;
end;

procedure TfrmCtaCadDupDDA.btnGeraCSVClick(Sender: TObject);
  Var
    prcScroll: TprcScroll;
begin
  Try
    Try
      pDisableControls(cdsSelDup, prcScroll);
      TfrmGravando.fExecutarModal(pGeraCsv, 'Gerando arquivo CSV. Aguarde...', '');
    Finally
      cdsSelDup.First;
      pEnableControls(cdsSelDup, prcScroll);
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, 'TfrmCtaCadDupDDA.btnGeraCSVClick');
  End;
end;

function TfrmCtaCadDupDDA.fVerificaDiv: Boolean;
  var
    intRecNo: Integer;
begin
  Result := False;

  intRecNo := cdsSelDup.RecNo;
  cdsSelDup.DisableControls;

  while not cdsSelDup.Eof do
  begin
    if (not fEmptyStr(cdsSelDup.FieldByName('CTP_NUMDUP').AsString)) Then
    Begin
      If (cdsSelDup.FieldByName('MARDES').AsString <> 'M') then
      begin
        Result := True;
        Break;
      end;
    End;

    cdsSelDup.Next;
  end;

  cdsSelDup.RecNo := intRecNo;
  cdsSelDup.EnableControls;

end;

procedure TfrmCtaCadDupDDA.BtnMarcarTodasClick(Sender: TObject);
var
  LOpcao: Integer;
begin
  If (Not cdsSelDup.Active) Then
  Begin
    fMensagem('', 'É necessário ter registros para marcar!', ['&Ok']);
    Exit;
  End;

  If (cdsSelDup.IsEmpty) Then
  Begin
    fMensagem('', 'É necessário ter registros para marcar!', ['&Ok']);
    Exit;
  End;

  LOpcao := fGetMenu('Selecione a opção', ['Cadastrar', 'Baixar Manualmente', 'Cancelar'], 1);

  If (LOpcao = 3) Then
    Exit;

  If (LOpcao = 1) Then
    MarcarTodasParaCadastrar
  Else If (LOpcao = 2) Then
    MarcarTodasParaBaixaManual;
end;

procedure TfrmCtaCadDupDDA.btnReprocessarClick(Sender: TObject);
  Var
    prcScroll: TprcScroll;
begin
  inherited;

  If edtDataInicial.Date = 0 Then
  Begin
    fMensagem('ATENÇÃO', 'A Data dos arquivos deve ser preenchida.', ['&Ok']);
    Exit;
  End;

  If fMensagem('ATENÇÃO', 'Tem certeza que deseja processar os registros?', ['&Sim', '&Não'], 1) = 2 Then
    Exit;

  Try
    pDisableControls(cdsSelDup, prcScroll);

    If cdsSelDup.Locate('MARDES', 'M', []) Then
    Begin
      fMensagem('ATENÇÃO', 'Para reprocessar os registros, não deve possuir nenhum registro marcado.', ['&Ok']);
      Exit;
    End;

    TFuncoesDDA.DataInicialDDA := edtDataInicial.Date;
    FDataInicial := TFuncoesDDA.DataInicialDDA;

    TfrmGravando.fExecutarModal(AtualizaFornecedoresSelecionados, 'Aguarde... Atualizando fornecedores.', '');

    pCriarFormularios(TfrmGravando,frmGravando);
    frmGravando.fExecutarAcao := TFuncoesDDA.fUpdAutoIncremCTPDDA;
    frmGravando.lblGravando.Caption := 'Aguarde... Atualizando Sequencial.';
    frmGravando.ShowModal;
    pFreeAndNil(frmGravando);
    
    TfrmGravando.fExecutarModal(pCriaTemporaria, 'Aguarde... Selecionando Duplicatas.', '');
    pSetFocus(grdDuplic);
  Finally
    pEnableControls(cdsSelDup, prcScroll);

    btnConfirma.Enabled := True;
    pnlInfo.Caption := '';
  End;
end;

function TfrmCtaCadDupDDA.DesmarcarDuplicata: Boolean;
  Var
    intOpc: Integer;

    strAutCtp: String;
begin
  if not blnMarcarT then
  begin
    if cdsSelDup.FieldByName('ACAO').AsString = 'Vincular' then
    begin
      intOpc :=  fMensagem('Opções', 'Selecione a ação:', ['&Ver Vínculo', '&Desmarcar'], 2, True, 1, 0, False, 0, False, False, True);
      if ( intOpc <> 2) Then
      begin
        TfrmCtaSelecionaDuplicataDDA.fSelecionaDuplicataCTP(
            cdsSelDup.FieldByName('DDA_AUTCTP').AsString,
            fRetSomenteNumeros(cdsSelDup.FieldByName('DDA_NUMDUP').AsString),
            cdsSelDup.FieldByName('PARCEL').AsString,
            cdsSelDup.FieldByName('DDA_CODEMP').AsString,
            cdsSelDup.FieldByName('FOR_CODCTA').AsString,
            cdsSelDup.FieldByName('PORTADOR').AsString,
            cdsSelDup.FieldByName('DDA_CODFOR').AsString,
            cdsSelDup.FieldByName('DDA_DTAVEN').AsDateTime,
            cdsSelDup.FieldByName('DDA_VALTIT').AsCurrency,
            strAutCtp,
            True);

        cdsSelDup.Cancel;
        Exit(False);
      end;
    end;
  end;

  cdsSelDup.FieldByName('MARDES').AsString := 'D';
  cdsSelDup.FieldByName('TOTSEL').Value    := 0;
  cdsSelDup.FieldByName('QTDSEL').Value    := 0;
  cdsSelDup.FieldByName('ACAO').AsString := '';

  Result := True;
end;

procedure TfrmCtaCadDupDDA.FormCreate(Sender: TObject);
begin
  inherited;
  pGeraTraducaoAutBan;

  If FileExists(ExtractFilePath(Application.ExeName) + '\PortuguesBrAutban.ini') Then
  Begin
    lcl.LoadFromFile(ExtractFilePath(Application.ExeName) + '\PortuguesBrAutban.ini');
    lcl.LanguageIndex := 1;
    lcl.Active := True;
  End;

  //Iniciando variáveis
  cdsSelDup := TZClient.Create(Self);
  grdDuplicDados.DataController.DataSource := cdsSelDup.fGetSource;
  pCriaAgrFields;

  blnMarcarT := False;

  If TFuncoesDDA.DataInicialDDA = 0 Then
    TFuncoesDDA.DataInicialDDA := IncMonth(VS_Date, -3);

  FDataInicial := TFuncoesDDA.DataInicialDDA;
  edtDataInicial.Date := FDataInicial;
end;

procedure TfrmCtaCadDupDDA.FormDestroy(Sender: TObject);
begin
  inherited;
  If Assigned(cdsSelDup) Then
    FreeAndNil(cdsSelDup);
end;

procedure TfrmCtaCadDupDDA.pCriaAgrFields;
begin
  With cdsSelDup Do
  Begin
    pCriaSoma('TOTSEL','TOT_TOTSEL' );
    pCriaSoma('DDA_VALTIT','TOT_VALTIT' );
    pCriaSoma('QTDSEL','TOT_QTDSEL' );
    pCriaSoma('DDA_NUMDUP','TOT_QTDTIT', 'COUNT(DDA_NUMDUP)' );
  End;
end;

procedure TfrmCtaCadDupDDA.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F4) Then
    btnBaixarDDA.Click
  Else If (Key = VK_F7) Then
    btnMarcarTodas.Click
  Else If (Key = VK_F8) Then
    btnDesmarcarTodas.Click
  Else If (Key = VK_F10) Then
    btnConfirma.Click
  Else If (Key = VK_F12) Then
    btnGeraCSV.Click
  Else If (Key = VK_ESCAPE) Then
    btnSair.Click;
end;

procedure TfrmCtaCadDupDDA.FormShow(Sender: TObject);
begin
  inherited;


  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := TFuncoesDDA.fAtualizaFornDDA;
  frmGravando.lblGravando.Caption := 'Aguarde... Atualizando Fornecedores.';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);

  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := TFuncoesDDA.fUpdAutoIncremCTPDDA;
  frmGravando.lblGravando.Caption := 'Aguarde... Atualizando Sequencial.';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);

  mskDtaIni.Date := FDataInicial;
  mskDtaFin.Date := VS_DATE;

  TfrmGravando.fExecutarModal(pCriaTemporaria, 'Aguarde... Selecionando Duplicatas.', '');
  TfrmGravando.fExecutarModal(pCriaTemporaria, 'Aguarde... Selecionando Duplicatas.', ''); //Aggregate field não atualizava da primeira vez
  pSetFocus(grdDuplic);
  Self.WindowState := wsMaximized;
end;

function TfrmCtaCadDupDDA.fUltimaParcela(strNumDup, strCodEmp,
  strCodFor: String): Integer;
  Var
    qrySelPar: TUniQuery;
begin
  qrySelPar := fCriaQuery(Nil);
  With qrySelPar Do
  Begin
    SQL.Text := 'SELECT COALESCE(MAX(CTP_PARCEL), "") AS ULTPAR FROM CADPAG WHERE ' +
                ' CTP_NUMDUP=:NUMDUP AND CTP_CODEMP=:CODEMP AND CTP_CODFOR=:CODFOR';
    ParamByName('NUMDUP').AsString := strNumDup;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODFOR').AsString := strCodFor;
    Open;

    Result := IIF(fEmptyStr(FieldByName('ULTPAR').AsString), 1, fGetPosLetraAlfa(FieldByName('ULTPAR').AsString) + 1);

    Close;
  End;
  FreeAndNil(qrySelPar);
end;

procedure TfrmCtaCadDupDDA.grdDuplicDadosATUALIZAHISTORICOPropertiesCloseUp(
  Sender: TObject);
begin
  inherited;
  If cdsSelDup.State = dsEdit Then
    pAtualizaHistorico;
end;

procedure TfrmCtaCadDupDDA.grdDuplicDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strMarDes,
    strCodFor,
    strNumDup: String;
    LDDA_C_G_C: String;
    LFOR_C_G_C: String;
begin
  inherited;

  If Not cdsSelDup.Active Then
    Exit;

  strMarDes  := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosMARDES.Index]);
  strCodFor  := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosFOR_CODFOR.Index]);
  strNumDup  := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosCTP_NUMDUP.Index]);
  LDDA_C_G_C := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosDDA_CNPJ_.Index]);
  LFOR_C_G_C := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosFOR_C_G_C_.Index]);

  If ((fEmptyStr(strCodFor)) and ((strMarDes = 'D') or (fEmptyStr(strMarDes)))) Then
    ACanvas.Font.Color := clGreen
  Else If strMarDes = 'M' Then
    ACanvas.Font.Color := clBlue
  Else If (LDDA_C_G_C <> LFOR_C_G_C)  And Not fEmptyStr(strNumDup)  Then // isso segnifica que esta vinculado a um fornecedor filial
    ACanvas.Font.Color := clOlive
  Else If Not fEmptyStr(strNumDup) Then
    ACanvas.Font.Color := clRed;
end;

procedure TfrmCtaCadDupDDA.grdDuplicDadosDblClick(Sender: TObject);
Var
  Key: Word;
begin
  inherited;
  If (Not cdsSelDup.Active) Or (cdsSelDup.IsEmpty) Then
  Begin
    fMensagem('', 'É necessário ter registros para marcar!', ['&Ok']);
    Exit;
  End
  Else
  Begin
    Key := VK_Return;
    grdDuplicDados.OnKeyDown(grdDuplicDados, Key, []);
  End;
end;

procedure TfrmCtaCadDupDDA.grdDuplicDadosDEPOSIGetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  AText := 'Não';
  if ARecord.Values[Sender.Index] = 'S' then
    AText := 'Sim';
end;

procedure TfrmCtaCadDupDDA.grdDuplicDadosFORNECEDORPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
  Var
    edtCodigo: TEditFocus;
    edtDescri: TEditFocus;
    arrSelecao: TConsultasArray;
    Key: Char;

    LOpcao : Integer;
begin
  LOpcao := 1;

  If Not cdsSelDup.FieldByName('FORNECEDOR').AsString.IsEmpty  Then
  Begin
    LOpcao := fMensagem('Opções', 'Selecione a ação:', ['&Vincular', '&Desvincular'], 1, True, 1, 0, False, 0, False, False, True);
  End;

  Try
      edtCodigo := TEditFocus.Create(Nil);
      edtDescri := TEditFocus.Create(Nil);

      Key := '/';

      If LOpcao = 1 Then
      Begin
        If fPesqFornecedor(conForSimples, Self, edtCodigo, edtDescri, Nil, Key, arrSelecao) Then
        Begin
          grdDuplicDadosFORNECEDOR.EditValue := edtCodigo.Text + '-' + edtDescri.Text; // start state in edit dataset
          cdsSelDup.FieldByName('ALTFOR').AsString := 'S';
          cdsSelDup.FieldByName('FOR_C_G_C_').AsString := fCampoTabela('FOR_C_G_C_', 'CADFOR', ['FOR_CODFOR'], [edtCodigo.Text]);
          cdsSelDup.FieldByName('FOR_CODFOR').AsString := edtCodigo.Text;
          cdsSelDup.FieldByName('DDA_CODFOR').AsString := edtCodigo.Text;
          grdDuplicDados.DataController.Dataset.Post; // start Post in edit dataset
        End
      End
      Else If LOpcao = 2 Then
      Begin
        grdDuplicDadosFORNECEDOR.EditValue := '';  // start state in edit dataset
        cdsSelDup.FieldByName('ALTFOR').AsString := 'S';
        cdsSelDup.FieldByName('FOR_C_G_C_').AsString := '';
        cdsSelDup.FieldByName('FOR_CODFOR').AsString := '';
        cdsSelDup.FieldByName('DDA_CODFOR').AsString := '';
        grdDuplicDados.DataController.Dataset.Post; // start Post in edit dataset
      End;

    Except
      On E: Exception Do
        pMensagensErro(E.Message,'');
    End;

    FreeAndNil(edtCodigo);
    FreeAndNil(edtDescri);
end;

procedure TfrmCtaCadDupDDA.grdDuplicDadosHISTORICOGetCellHint(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  ACellViewInfo: TcxGridTableDataCellViewInfo; const AMousePos: TPoint;
  var AHintText: TCaption; var AIsHintMultiLine: Boolean;
  var AHintTextRect: TRect);
begin
  inherited;
  if ARecord.Values[Sender.Index] <> null then
  begin
    Application.HintColor := clSilver;
    AIsHintMultiLine := True;
    HintControler.ShowHint(Self.Left + AHintTextRect.Left,
                          30 + Self.Top + AHintTextRect.Top + AHintTextRect.Height,
                          '',
                          ARecord.Values[Sender.Index],
                          500);
  end
  Else
    HintControler.HideHint;
end;

procedure TfrmCtaCadDupDDA.grdDuplicDadosHISTORICOGetPropertiesForEdit(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
begin
  inherited;
  HintControler.HideHint;
  if ARecord.Index >= 0 then
  begin
    AProperties := grdDuplicDadosATUALIZAHISTORICO.Properties;
    AProperties.ImmediatePost := True;
  end;
end;

procedure TfrmCtaCadDupDDA.grdDuplicDadosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Not cdsSelDup.Active) Or (cdsSelDup.IsEmpty) Then
    Exit;

  If (Key = VK_Return) Or (Key = VK_SPACE) Then
  Begin
    grdDuplic.Enabled := False;
    pnlBotoes.Enabled := False;

    If ((fEmptyStr(cdsSelDup.FieldByName('DDA_CODFOR').AsString)) and (cdsSelDup.FieldByName('MARDES').AsString <> 'M')) Then
      pMensagemOK('Essa duplicata não pode ser marcada pois não possui Fornecedor vinculado!')
    Else If ((fEmptyStr(cdsSelDup.FieldByName('FOR_CODFOR').AsString)) and (cdsSelDup.FieldByName('MARDES').AsString <> 'M')) Then
      pMensagemOK('Essa duplicata não pode ser marcada pois não possui Fornecedor vinculado!')
    Else
    Begin
      pSelecionaDuplicata;
      If (cdsSelDup.RecordCount > 0) Then
        Key := VK_DOWN;
    End;

    grdDuplic.Enabled := True;
    pSetFocus(grdDuplic);
    pnlBotoes.Enabled := True;
  End;
end;

procedure TfrmCtaCadDupDDA.MarcarTodasParaBaixaManual;
begin
  If Not (fMensagem('AVISO!', 'Confirma baixa manual da(s) duplicata(s) nas rotinas do DDA?' + #13 + #13 +
                    'As duplicatas deixaram de ser listada nas rotinas do DDA e em caso de estar'  + #13 +
                    'pendente no banco, a linha dígitavel/código de barras deve ser informada' + #13+
                    'direto no manutenção do contas a pagar ou a baixa, no banco, deverá' + #13 +
                    'ocorrer de forma manual.', ['&Sim', '&Não'], 2, True, 1, 0, False, 0, False, False, False, 230) = 1) then
  Exit;

  pnlBotoes.Enabled := False;
  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fMarcarTodasBaixaManual;
  frmGravando.lblGravando.Caption := 'Aguarde... Marcando duplicatas para baixa manual.';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
  pnlBotoes.Enabled := True;

end;

procedure TfrmCtaCadDupDDA.MarcarTodasParaCadastrar;
begin

  If rdgFiltrar.ItemIndex = 1 Then
  Begin
    fMensagem('ATENÇÃO', 'Não é possível marcar/desmarcar duplicatas sem fornecedor vinculado!', ['&Ok']);
    Exit;
  End;

  If (fMensagem('', 'Confirma selecionar todas as duplicatas?', ['&Sim', '&Não']) = 2) Then
    Exit;

  blnComDiv := fVerificaDiv;
  If blnComDiv Then
  Begin
    If fMensagem('', 'Alguns documentos filtrados foram encontrados no sistema, mas com o número cadastrado diferente do importado no arquivo.' + #13 + 'Deseja realmente continuar?', ['&Sim', '&Não']) = 2 Then
      Exit;
  End;

  pnlBotoes.Enabled := False;
  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fMarcarTodas;
  frmGravando.lblGravando.Caption := 'Aguarde... Marcando Duplicatas.';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
  pnlBotoes.Enabled := True;
end;

procedure TfrmCtaCadDupDDA.pCriaTemporaria;
Var strSQL,
    strCodFor: String;
    prcScroll: TprcScroll;
begin
  strSQL := '';

  //Locate do CodFor
  strCodFor := ' ((P.CTP_CODFOR = D.DDA_CODFOR) OR (LOCATE(P.CTP_CODFOR, D.DDA_CODFIL) > 0)) ';


  strSQL := strSQL + 'SELECT                                                 ';
  strSQL := strSQL + '  D.*,                                                 ';
  strSQL := strSQL + '  P.*,                                                 ';
  strSQL := strSQL + '  E.EMP_NOMEMP,                                        ';
  strSQL := strSQL + '  IFNULL(F.FOR_CODFOR, L.FOR_CODFOR) AS FOR_CODFOR,    ';
  strSQL := strSQL + '  IFNULL(F.FOR_NOMFOR, L.FOR_NOMFOR) AS FOR_NOMFOR,    ';
  strSQL := strSQL + '  IFNULL(F.FOR_C_G_C_, L.FOR_C_G_C_) AS FOR_C_G_C_,    ';
  strSQL := strSQL + '  CONCAT(                                              ';
  strSQL := strSQL + '    IFNULL(F.FOR_CODFOR, L.FOR_CODFOR),                ';
  strSQL := strSQL + '    "-",                                               ';
  strSQL := strSQL + '    IFNULL(F.FOR_NOMFOR, L.FOR_NOMFOR)                 ';
  strSQL := strSQL + '  ) AS FORNECEDOR,                                     ';
  strSQL := strSQL + ' "N" AS ALTFOR,                                        ';
  strSQL := strSQL + ' L.FOR_C_G_C_ AS CTPFOR,                               ';

  If Not fCfgSis('USACTF', varBoolean) Then
    strSQL := strSQL + ' IF(COALESCE(IFNULL(F.FOR_CODCTA,L.FOR_CODCTA), "") = "", "' + Trim(fGetBancoConfig(0, FstrConfig, 'CTACTP_', '')) + '", IFNULL(F.FOR_CODCTA,L.FOR_CODCTA)) AS FOR_CODCTA, '
  Else
  Begin
    strSQL := strSQL + ' IF(COALESCE((SELECT CTF_CODCTA FROM CTAFOR ';
    strSQL := strSQL + ' WHERE CTF_CODFOR=IFNULL(F.FOR_CODFOR,L.FOR_CODFOR) AND CTF_CODCTA="' + Trim(fGetBancoConfig(0, FstrConfig, 'CTACTP_', '')) + '" ';
    strSQL := strSQL + ' ),"") = "", (SELECT CTF_CODCTA FROM CTAFOR ';
    strSQL := strSQL + ' WHERE CTF_CODFOR=IFNULL(F.FOR_CODFOR,L.FOR_CODFOR) LIMIT 1), "' + Trim(fGetBancoConfig(0, FstrConfig, 'CTACTP_', '')) + '" ) AS FOR_CODCTA, ';
  End;

  strSQL := strSQL + 'CAST("' + Trim(fGetBancoConfig(0, FstrConfig, 'PORCTP_', '')) + '" AS CHAR(5)) AS PORTADOR, ';
  strSQL := strSQL + 'CAST("' + Trim(fGetBancoConfig(0, FstrConfig, 'EVECTP_', '')) + '" AS CHAR(5)) AS EVENTO, ';
  strSQL := strSQL + ' "A" AS PARCEL, ';

  strSQL := strSQL + ' CONCAT(DDA_CNPJ__, "-", DDA_NOMCED) AS CEDENTE, ';

  strSQL := strSQL + ' "S" AS VEIOBO, "N" AS VEIONF, "N" AS USACHQ, "N" AS PREVIS, "N" AS DEPOSI, ';
  strSQL := strSQL + ' "D" AS MARDES, CAST(0 AS DECIMAL(15,2)) AS TOTSEL, 0 AS QTDSEL, CAST(" " AS CHAR(100)) AS ACAO ';

  strSQL := strSQL + '  FROM RETDDA D ';
  strSQL := strSQL + '  LEFT JOIN CADPAG P ON (P.AUTOINCREM = D.DDA_AUTCTP) ';
  strSQL := strSQL + '  LEFT JOIN CADFOR F ON (F.FOR_CODFOR = D.DDA_CODFOR) ';
  strSQL := strSQL + '  LEFT JOIN CADEMP E ON (E.EMP_CODEMP = D.DDA_CODEMP) ';
  strSQL := strSQL + '  LEFT JOIN CADFOR L ON (L.FOR_CODFOR = P.CTP_CODFOR) ';

  strSQL := strSQL + '  WHERE D.DDA_CODBCO="' + Trim(Copy(FstrConfig, 10, 3)) + '" ';
  strSQL := strSQL + '    AND D.DDA_DTAARQ>="' + FormatDateTime('yyyy-mm-dd', FDataInicial) + '" ';
  strSQL := strSQL + '    AND D.DDA_DTABAI IS NULL ';

  strSQL := 'SELECT * FROM (' + strSQL + ') RETTMP ';

  strSQL := strSQL + ' GROUP BY DDA_LINDIG ORDER BY DDA_CODMOV, DDA_NUMDUP, DDA_CODEMP, DDA_DTAVEN';

  Try
    pDisableControls(cdsSelDup, prcScroll);

    With cdsSelDup, qryQuery Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      fAbreClient(True, 'TfrmCtaCadDupDDA.pCriaTemporaria');

      Application.ProcessMessages;

      cdsSelDup.Filter   := '';
      cdsSelDup.Filtered := False;
    End;

    pAtualizarParcelas;

    TFloatField(cdsSelDup.FieldByName('DDA_VALTIT')).DisplayFormat    := '#,##0.00';

    btnConsultar.Click;

    grdDuplicDados.DataController.Datasource := cdsSelDup.fGetSource;
  Finally
    pEnableControls(cdsSelDup, prcScroll);
    pAtualizaTemporaria;
  End;
end;

procedure TfrmCtaCadDupDDA.pGeraCsv;
  Var
    svdCsv: TSaveDialog;
begin
  inherited;

  svdCsv := TSaveDialog.Create(Nil);
  svdCsv.Filter := 'Arquivo CSV|*.csv';
  svdCsv.DefaultExt := 'csv';

  If svdCsv.Execute Then
  Begin

    ExportGridToCSV(svdCsv.FileName, grdDuplic, True, True,';', 'csv', nil, TEncoding.UTF8);

    fMensagem('','Arquivo CSV gerado com sucesso!!', ['&O K']);
  End;

  FreeAndNil(svdCsv);
end;

procedure TfrmCtaCadDupDDA.pAtualizaHistorico;
  const
  SQL_UPDATE =
    ' UPDATE RETDDA' +
    ' SET ' +
    '   DDA_HIST01 = :HIST01'  +
    ' WHERE DDA_CODBCO = :CODBCO' +
    '   AND DDA_BCOCOM = :BCOCOM' +
    '   AND DDA_CODEMP = :CODEMP' +
    '   AND DDA_NUMDUP = :NUMDUP' +
    '   AND DDA_CODFOR = :CODFOR' +
    '   AND DDA_DTAVEN = :DTAVEN' +
    '   AND DDA_VALTIT = :VALTIT';

  Var
    qryUpdHIS: TUniQuery;
begin
  inherited;

  Application.ProcessMessages;

  Try
    qryUpdHIS := fCriaQuery(Nil);

    qryUpdHIS.Close;
    qryUpdHIS.SQL.Clear;
    qryUpdHIS.SQL.Add(SQL_UPDATE);

    qryUpdHIS.ParamByName('CODBCO').AsString   := cdsSelDup.FieldByName('DDA_CODBCO').AsString;
    qryUpdHIS.ParamByName('BCOCOM').AsString   := cdsSelDup.FieldByName('DDA_BCOCOM').AsString;
    qryUpdHIS.ParamByName('NUMDUP').AsString   := cdsSelDup.FieldByName('DDA_NUMDUP').AsString;
    qryUpdHIS.ParamByName('CODFOR').AsString   := cdsSelDup.FieldByName('DDA_CODFOR').AsString;
    qryUpdHIS.ParamByName('CODEMP').AsString   := cdsSelDup.FieldByName('DDA_CODEMP').AsString;
    qryUpdHIS.ParamByName('DTAVEN').AsDateTime := cdsSelDup.FieldByName('DDA_DTAVEN').AsDateTime;
    qryUpdHIS.ParamByName('VALTIT').Value      := cdsSelDup.FieldByName('DDA_VALTIT').Value;
    qryUpdHIS.ParamByName('HIST01').AsString   := cdsSelDup.FieldByName('DDA_HIST01').AsString;
    qryUpdHIS.ExecSQL;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TfrmCtaCadDupDDA.pAtualizaHistorico');
    End;
  End;

  qryUpdHIS.Close;
  FreeAndNil(qryUpdHIS);
end;

procedure TfrmCtaCadDupDDA.pAtualizarParcelas;
var
  LfrmGravando: TfrmGravando;
begin
  pCriarFormularios(TfrmGravando,LfrmGravando);
  try
    LfrmGravando.fExecutarAcao := fAtualizarParcelas;
    LfrmGravando.lblGravando.Caption := 'Aguarde... Atualizando Parcelas.';
    LfrmGravando.ShowModal;
  finally
    pFreeAndNil(LfrmGravando);
  end;
end;

function TfrmCtaCadDupDDA.fAtualizarParcelas(pgbProgresso: TcxProgressBar): Boolean;
  Var
    strNumDup,
    strCodFor,
    strCodEmp,
    strDupCor: String;
    intParcel: Integer;
    LRecNoBackup: Integer;
    LFilterBackup: string;
begin
  strNumDup := '';
  strCodFor := '';
  strCodEmp := '';
  intParcel := 1;
  Result := True;

  LRecNoBackup := cdsSelDup.RecNo;
  LFilterBackup := cdsSelDup.Filter;

  With cdsSelDup do
  Begin
    If (Not Active) Or (IsEmpty) Then
      Exit;

    cdsSelDup.DisableControls;
    Try
      IndexFieldNames := 'DDA_CODEMP;DDA_DUPCOR;FOR_CODFOR;DDA_DTAVEN';
      Try
        pgbProgresso.Position := 0;
        pgbProgresso.Properties.Max := RecordCount;

        First;
        While Not Eof do
        Begin
          Application.ProcessMessages;
          strDupCor := fRetSomenteNumeros(FieldByName('DDA_DUPCOR').AsString);
          If ((fEmptyStr(strDupCor)) Or
             (StrtoInt64(strDupCor) = 0) Or
             (Not fEmptyStr(FieldByName('CTP_NUMDUP').AsString) And
             (FieldByName('CTP_VALDUP').Value <> FieldByName('DDA_VALTIT').Value))
             Or (fVerificaLinDigCtaPag(False, FieldByName('DDA_LINDIG').AsString,
                 FieldByName('DDA_CODBAR').AsString).Count > 0)) Or
             ((Not fEmptyStr(FieldByName('DDA_AUTCTP').AsString)) And (TFuncoesDDA.ValidaNumeroDuplicataDDA(FieldByName('CTP_NUMDUP').AsString, strDupCor))) Then
          Begin
            Delete;
            pStep(pgbProgresso);
            Continue;
          End;

          If FieldByName('FOR_CODFOR').AsString <> '' Then
          Begin
            If (strNumDup <> fRetSomenteNumeros(FieldByName('DDA_DUPCOR').AsString)) Or
               (strCodEmp <> FieldByName('DDA_CODEMP').AsString) Or
               (strCodFor <> FieldByName('FOR_CODFOR').AsString) Then
            Begin
              strNumDup := fRetSomenteNumeros(FieldByName('DDA_DUPCOR').AsString);
              strCodEmp := FieldByName('DDA_CODEMP').AsString;
              strCodFor := FieldByName('FOR_CODFOR').AsString;
              intParcel := fUltimaParcela(FieldByName('DDA_DUPCOR').AsString,
                                          FieldByName('DDA_CODEMP').AsString,
                                          FieldByName('FOR_CODFOR').AsString);
            End
            Else
              intParcel := intParcel + 1;

            Edit;
            FieldByName('PARCEL').AsString    := fGetLetraAlfa(intParcel);
            Post;
          End;

          pStep(pgbProgresso);
          Next;
        End;
      except
        On E: Exception Do
        Begin
          pMensagensErro('Ocorreu um erro ao atualizar as parcelas.' + #13 +
                         'Erro gerado: ' + E.Message, '[fAtualizarParcelas');
        End;
      End;
    Finally
      RecNo    := LRecNoBackup;
      Filter   := LFilterBackup;
      Filtered := Not fEmptyStr(Filter);
      cdsSelDup.EnableControls;
    End;
  End;
end;

procedure TfrmCtaCadDupDDA.pAtualizaTemporaria;
begin
  edtTotalDup.Text         := '0,00';
  edtTotalSelecionado.Text := '0,00';
  edtQtdDup.Text           := '0';
  edtSelDup.Text           := '0';

  If Not cdsSelDup.IsEmpty Then
  Begin
    edtTotalDup.Text         := FormatFloat('#,##0.00', cdsSelDup.fRetSoma('TOT_VALTIT'));
    edtTotalSelecionado.Text := FormatFloat('#,##0.00', cdsSelDup.fRetSoma('TOT_TOTSEL'));
    edtQtdDup.Text           := cdsSelDup.fRetSoma('TOT_QTDTIT').ToString;
    edtSelDup.Text           := cdsSelDup.fRetSoma('TOT_QTDSEL').ToString;
  End;
end;

procedure TfrmCtaCadDupDDA.pSelecionaDuplicata;
  var
    intOpc: Integer;
    strAutCtp: String;
    strPagAnt: String;
begin
  cdsSelDup.Edit;
  If cdsSelDup.FieldByName('MARDES').AsString <> 'M' Then
  Begin
    //Abre a tela de digitação de dados no caso de selecionar apenas uma duplicata
    If Not blnMarcarT Then
    Begin
      intOpc :=  fMensagem('Opções', 'Selecione a ação:', ['&Cadastrar', '&Procurar'], 1, True, 1, 0, False, 0, False, False, True);
      if ( intOpc = 1) Then
      begin
        If (fEmptyStr(cdsSelDup.FieldByName('CTP_PAGANT').AsString)) Then
          strPagAnt := 'N'
        Else
          strPagAnt := cdsSelDup.FieldByName('CTP_PAGANT').Value;

        pCriarFormularios(TfrmCtaDigDadosDDA, frmCtaDigDadosDDA);
        frmCtaDigDadosDDA.strCodPor := cdsSelDup.FieldByName('PORTADOR').AsString;
        frmCtaDigDadosDDA.strCodCta := cdsSelDup.FieldByName('FOR_CODCTA').AsString;
        frmCtaDigDadosDDA.strCodEve := cdsSelDup.FieldByName('EVENTO').AsString;
        frmCtaDigDadosDDA.strVeioBo := cdsSelDup.FieldByName('VEIOBO').AsString;
        frmCtaDigDadosDDA.strVeioNF := cdsSelDup.FieldByName('VEIONF').AsString;
        frmCtaDigDadosDDA.strUsaChq := cdsSelDup.FieldByName('USACHQ').AsString;
        frmCtaDigDadosDDA.strDeposi := cdsSelDup.FieldByName('DEPOSI').AsString;
        frmCtaDigDadosDDA.strPrevis := cdsSelDup.FieldByName('PREVIS').AsString;
        frmCtaDigDadosDDA.strCodEmp := cdsSelDup.FieldByName('DDA_CODEMP').AsString;
        frmCtaDigDadosDDA.strCodFor := cdsSelDup.FieldByName('DDA_CODFOR').AsString;
        frmCtaDigDadosDDA.strHist01 := cdsSelDup.FieldByName('DDA_HIST01').AsString;
        frmCtaDigDadosDDA.strPagAnt := strPagAnt;

        frmCtaDigDadosDDA.ShowModal;

        If Not frmCtaDigDadosDDA.blnConfirma Then
        Begin
          cdsSelDup.Cancel;
          FreeAndNil(frmCtaDigDadosDDA);
          Exit;
        End;

        cdsSelDup.FieldByName('FOR_CODCTA').Value:= frmCtaDigDadosDDA.strCodCta;
        cdsSelDup.FieldByName('PORTADOR').Value  := frmCtaDigDadosDDA.strCodPor;
        cdsSelDup.FieldByName('EVENTO').Value    := frmCtaDigDadosDDA.strCodEve;
        cdsSelDup.FieldByName('VEIONF').Value    := frmCtaDigDadosDDA.strVeioNF;
        cdsSelDup.FieldByName('VEIOBO').Value    := frmCtaDigDadosDDA.strVeioBo;
        cdsSelDup.FieldByName('USACHQ').Value    := frmCtaDigDadosDDA.strUsaChq;
        cdsSelDup.FieldByName('PREVIS').Value    := frmCtaDigDadosDDA.strPrevis;
        cdsSelDup.FieldByName('DEPOSI').Value    := frmCtaDigDadosDDA.strDeposi;
        cdsSelDup.FieldByName('DDA_HIST01').Value:= frmCtaDigDadosDDA.strHist01;
        cdsSelDup.FieldByName('CTP_PAGANT').Value:= frmCtaDigDadosDDA.strPagAnt;

        FreeAndNil(frmCtaDigDadosDDA);

        cdsSelDup.FieldByName('ACAO').AsString := 'Cadastrar';
      end;

      if ( intOpc = 2) Then
      begin
        strAutCtp := '';
        if Not TfrmCtaSelecionaDuplicataDDA.fSelecionaDuplicataCTP(
                  cdsSelDup.FieldByName('DDA_AUTCTP').AsString,
                  fRetSomenteNumeros(cdsSelDup.FieldByName('DDA_NUMDUP').AsString),
                  cdsSelDup.FieldByName('PARCEL').AsString,
                  cdsSelDup.FieldByName('DDA_CODEMP').AsString,
                  cdsSelDup.FieldByName('FOR_CODCTA').AsString,
                  cdsSelDup.FieldByName('PORTADOR').AsString,
                  cdsSelDup.FieldByName('DDA_CODFOR').AsString,
                  cdsSelDup.FieldByName('DDA_DTAVEN').AsDateTime,
                  cdsSelDup.FieldByName('DDA_VALTIT').AsCurrency,
                  strAutCtp) then
        begin
          cdsSelDup.Cancel;
          Exit;
        End;

        cdsSelDup.FieldByName('ACAO').AsString := 'Vincular';
        cdsSelDup.FieldByName('DDA_AUTCTP').AsString := strAutCtp;
      end;

      if ( intOpc = 0) Then
      begin
        cdsSelDup.Cancel;
        Exit;
      end;
    End
    Else
      cdsSelDup.FieldByName('ACAO').AsString := 'Cadastrar';

    cdsSelDup.FieldByName('MARDES').AsString := 'M';
    cdsSelDup.FieldByName('TOTSEL').Value    := cdsSelDup.FieldByName('DDA_VALTIT').Value;
    cdsSelDup.FieldByName('QTDSEL').Value    := 1;
  End
  Else If Not DesmarcarDuplicata Then
    Exit;

  cdsSelDup.Post;

  pAtualizarParcelas;

  If Not blnMarcarT Then
    pAtualizaTemporaria;
end;

end.
