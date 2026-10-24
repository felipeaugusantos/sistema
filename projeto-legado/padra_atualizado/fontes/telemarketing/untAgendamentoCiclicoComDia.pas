unit untAgendamentoCiclicoComDia;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, untPai, Menus, StdCtrls, Buttons,
  ExtCtrls, EditFocus, untFuncoes, untFuncoesSimples, Grids, DBGridCitel, DBGrids, DB, UniClientDataSet,
  UniDataSetProvider, Uni, Mask, MaskEditFocus, AppEvnts, BitBtnLockedIncrem, MemDS, DBAccess,
  Provider, untTypesSistema, frxClass, frxExportCSVTestabilidade,
  Datasnap.DBClient, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, cxCalendar, cxCurrencyEdit;

type

  TfrmAgendamentoCiclicoComDia = class(TfrmPai)
    Panel1: TPanel;
    lblVenRep: TLabel;
    edtCodVendedor: TEditFocus;
    edtDesVendedor: TEditFocus;
    dbgAgendamento: TDBGridCitel;
    qryConsulta: TUniQuery;
    dspConsulta: TUniDataSetProvider;
    cdsConsulta: TUniClientDataSet;
    dtsConsulta: TDataSource;
    shpVen: TShape;
    btnMarDes: TBitBtnLocked;
    btnMarDesTodos: TBitBtnLocked;
    btnAltData: TBitBtnLocked;
    cxGridAgendamento: TcxGridCitel;
    cxGridAgendamentoDBView: TcxGridDBTableViewCitel;
    cxGridAgendamentoCLI_CODVEN: TcxGridDBColumn;
    cxGridAgendamentoCLI_CODCLI: TcxGridDBColumn;
    cxGridAgendamentoCLI_NOMCLI: TcxGridDBColumn;
    cxGridAgendamentoCLI_BAIRRO: TcxGridDBColumn;
    cxGridAgendamentoREG_DESREG: TcxGridDBColumn;
    cxGridAgendamentoCID_NOMCID: TcxGridDBColumn;
    cxGridAgendamentoCID_ESTADO: TcxGridDBColumn;
    cxGridAgendamentoATI_DESATI: TcxGridDBColumn;
    cxGridAgendamentoAGE_DTABAI: TcxGridDBColumn;
    cxGridAgendamentoAGE_DTAAGE: TcxGridDBColumn;
    cxGridAgendamentoCLI_INICIC: TcxGridDBColumn;
    cxGridAgendamentoCLI_INTERV: TcxGridDBColumn;
    cxGridAgendamentoCLI_ULTCOM: TcxGridDBColumn;
    cxGridAgendamentoCLI_NASCIM: TcxGridDBColumn;
    cxGridAgendamentoTOT_ORABER: TcxGridDBColumn;
    cxGridAgendamentoTOT_PDABER: TcxGridDBColumn;
    cxGridAgendamentoPrimeiroNivel: TcxGridLevel;
    cxGridAgendamentoMARDES: TcxGridDBColumn;
    btnCadCli: TBitBtnLocked;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    cxGridAgendamentoSUB_DESSUB: TcxGridDBColumn;
    btnVendasCliente: TBitBtnLocked;
    rdgStatusCliente: TRadioGroup;
    cxGridAgendamentoCLI_STATUS: TcxGridDBColumn;
    procedure edtCodVendedorExit(Sender: TObject);
    procedure edtCodVendedorKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure dbgAgendamentoDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure cdsConsultaAfterInsert(DataSet: TDataSet);
    procedure cdsConsultaAfterPost(DataSet: TDataSet);
    procedure FormResize(Sender: TObject);
    procedure cdsConsultaBeforePost(DataSet: TDataSet);
    procedure edtCodVendedorEnter(Sender: TObject);
    procedure ApplicationEventsException(Sender: TObject; E: Exception);
    procedure btnMarDesClick(Sender: TObject);
    procedure btnMarDesTodosClick(Sender: TObject);
    procedure btnAltDataClick(Sender: TObject);
    procedure cxGridAgendamentoDBViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxGridAgendamentoDBViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxGridAgendamentoDBViewCellDblClick(
      Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure btnCadCliClick(Sender: TObject);
    procedure dtsConsultaDataChange(Sender: TObject; Field: TField);
    procedure btnVendasClienteClick(Sender: TObject);
  private
    { Private declarations }
    arrVendedor  : TConsultasArray;
    blnLiberado  : Boolean;
    strCodVen    : String;
    strVenRep    : String;

    function fAbreConsulta(blnLike: Boolean): Boolean;
    function fAtualizaCliente(DataSet: TDataSet): Boolean;
    function fAtualizaAgendamento(DataSet: TDataSet): Boolean;

    procedure pVerdeVermelho(edtCodigo: TEditFocus; Shape: TShape);
  public
    { Public declarations }
    tagTipAge: TTipoAgendamento;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

const
  strRegistroNaoSelecionado =  'É preciso selecionar um registro!';
  strInicioDoCiclo = 'O dia de início do ciclo deve estar enter 0 e 31 dias!';
  strIntervaloMaiorQueZero = 'O intervalo de dias deve ser maior que zero.';
  strIntervaloMaiorOuIgualAZero = 'O intervalo de dias deve ser maior ou igual a zero.';
  strDataDeAgendamentoInvalida = 'A data de gendamento é inválida.';
  strDataDeAgendamentoMaiorOuIgualHoje = 'A data de agendamento deve ser maior ou igual a hoje.';


implementation

uses
  Graphics, StrUtils, untConsultas, untFuncoesConsulta, untDigDataMsk, untCadClientes, untRelFatVendasCliente;

{$R *.dfm}

Const
  SET_OF_TYPES : Set of TFieldType = [ftString,ftWideString,ftDate,ftDateTime,ftInteger,ftLargeInt,ftWord,ftFloat];

procedure TfrmAgendamentoCiclicoComDia.edtCodVendedorExit(Sender: TObject);
begin
  inherited;
  If blnLiberado Then
    pEdtCodSelectExit(edtCodVendedor,edtDesVendedor,arrVendedor,fRetNomVendRep,nil, IIF(strVenRep = 'Vendedor', 'do Vendedor', 'do Representante'));
end;

procedure TfrmAgendamentoCiclicoComDia.edtCodVendedorKeyPress(
  Sender: TObject; var Key: Char);
var
  arrSel : TConsultasArray;
begin
  inherited;
  If blnLiberado And fPesqOperador(Self, edtCodVendedor, edtDesVendedor, qryTabela, Key, arrSel) Then
  Begin
    fValidaCampos(edtCodVendedor, False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmAgendamentoCiclicoComDia.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin
    If (Sender = edtCodVendedor) Then
    Begin
      If blnLiberado Then
      Begin
        strCodVen := edtCodVendedor.Text;
      End
      Else If Not fEmptyStr(edtCodVendedor.Text) Then
      Begin
        strCodVen := fRetCodVendedor(edtCodVendedor.Text);
        If Not fEmptyStr(strCodVen) Then
          edtDesVendedor.Text := fRetNomVendRep(strCodVen)
        Else
        Begin
          Result := False;
          fMensagem('', strVenRep + ' não encontrado.', ['&O K']);
        End;
      End
      Else If fEmptyStr(edtCodVendedor.Text) Then
      Begin
        edtDesVendedor.Text := '';
        cdsConsulta.Close;
        Result := False;
        fMensagem('ATENÇÃO','O ' + strVenRep + ' deve ser preenchido.', ['&O K']);
      End;

      If Result Then
        fAbreConsulta(True);

    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmAgendamentoCiclicoComDia.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If cdsConsulta.State in [dsInsert, dsEdit] Then
    cdsConsulta.Post;
  cdsConsulta.Close;
end;

function TfrmAgendamentoCiclicoComDia.fAbreConsulta(blnLike: Boolean): Boolean;
Var
  strVendedor: String;
  intIndex   : Integer;
Begin
  Try
    With qryConsulta, Sql Do
    Begin
      Close;
      cdsConsulta.Close;
      Clear;

      Add('SELECT                                              ');

      Add('  CLI_ULTCOM,                                       ');
      Add('  DATE_FORMAT(IF(CLI_CGCCPF = 2, CLI_NASCIM, ""),"%d/%m/%Y") AS CLI_NASCIM, ');

      Add('  (                                                 ');
      Add('  SELECT                                            ');
      Add('    COUNT(*)                                        ');
      Add('  FROM                                              ');
      Add('    FATGOR                                          ');
      Add('  WHERE                                             ');
      Add('    FGO_CODCLI = CLI_CODCLI AND                     ');
      Add('    FGO_ESPDOC = "OR"       AND                     ');
      Add('    FGO_JAFATU = 0          AND                     ');
      Add('    FGO_VLRCON > 0                                  ');
      Add('  ) AS TOT_ORABER,                                  ');

      Add('  (                                                 ');
      Add('  SELECT                                            ');
      Add('    COUNT(*)                                        ');
      Add('  FROM                                              ');
      Add('    FATGOR                                          ');
      Add('  WHERE                                             ');
      Add('    FGO_CODCLI = CLI_CODCLI AND                     ');
      Add('    FGO_ESPDOC = "PD"       AND                     ');
      Add('    FGO_JAFATU = 0          AND                     ');
      Add('    FGO_VLRCON > 0                                  ');
      Add('  ) AS TOT_PDABER,                                  ');

      Add('0 AS MARDES,                                ');
      If SameText(fCfgSis('TELVRP'), '1') Then
        Add('  CLI_CODVEN,                             ')
      Else
        Add('  CLI_CODREP AS CLI_CODVEN,               ');

      Add('  CLI_CODCLI,                               ');
      Add('  IF(CLI_STATUS = "A", "Ativo", "Inativo") AS STATUS,');
      Add('  IF((CLI_NOMCLI IS NULL) OR (CLI_NOMCLI = "")," ", CLI_NOMCLI) AS CLI_NOMCLI,     ');
      Add('  IF((CID_NOMCID IS NULL) OR (CID_NOMCID = "")," ", CID_NOMCID) AS CID_NOMCID,     ');
      Add('  IF((CID_ESTADO IS NULL) OR (CID_ESTADO = "")," ", CID_ESTADO) AS CID_ESTADO,     ');
      Add('  IF((ATI_DESATI IS NULL) OR (ATI_DESATI = "")," ", ATI_DESATI) AS ATI_DESATI,     ');

      Add('  IF((CLI_BAIRRO IS NULL) OR (CLI_BAIRRO = "")," ", CLI_BAIRRO) AS CLI_BAIRRO,     ');
      Add('  IF((REG_DESREG IS NULL) OR (REG_DESREG = "")," ", REG_DESREG) AS REG_DESREG,     ');

      Add('  IF((SUB_DESSUB IS NULL) OR (SUB_DESSUB = "")," ", SUB_DESSUB) AS SUB_DESSUB,     ');

      If tagTipAge = taManual Then
      Begin

        Add('DATE_FORMAT((SELECT                       ');
        Add('   MAX(AGE_DTABAI)                        ');
        Add(' FROM                                     ');
        Add('   AGETEL                                 ');
        Add(' WHERE                                    ');
        Add('   CLI_CODCLI = AGE_CODCLI AND            ');
        Add('   AGE_CODEMP = ' + QuotedStr(VS_strCodEmp) +  ' AND ');
        Add('   AGE_DTABAI IS NOT NULL),               ');
        Add('           "%d/%m/%Y") AS AGE_DTABAI,     ');

        Add('CAST(                                     ');
        Add('  (SELECT                                 ');
        Add('     MIN(AGE_DTAAGE)                      ');
        Add('   FROM                                   ');
        Add('     AGETEL                               ');
        Add('   WHERE                                  ');
        Add('     CLI_CODCLI = AGE_CODCLI AND          ');
        Add('     AGE_CODEMP = ' + QuotedStr(VS_strCodEmp) +  ' AND ');
        Add('     AGE_DTABAI IS NULL AND               ');
        Add('     AGE_DTAAGE >= '+QuotedStr(FormatDateTime('yyyy-mm-dd',VS_Date)));
        Add('  ) AS DATE) AS AGE_DTAAGE                ');
      End
      Else
      Begin

        Add('  CLI_INICIC,   ');
        Add('  CLI_INTERV    ');

      End;

      Add('FROM                                        ');
      Add('  CADCLI                                    ');
      Add('LEFT JOIN CADCID ON CLI_CODCID = CID_CODCID ');
      Add('LEFT JOIN CADATI ON CLI_CODATI = ATI_CODATI ');
      Add('LEFT JOIN CADREG ON CLI_CODREG = REG_CODREG ');
      Add('LEFT JOIN CADSUB ON CLI_CODSUB = SUB_CODSUB ');
      Add('WHERE                                       ');

      If SameText(fCfgSis('TELVRP'), '1') Then
      Begin
        Add('  CLI_CODVEN IS NOT NULL AND              ');
        Add('  CLI_CODVEN <> ""                        ');
      End
      Else
      Begin
        Add('  CLI_CODREP IS NOT NULL AND              ');
        Add('  CLI_CODREP <> ""                        ');
      End;

      case rdgStatusCliente.ItemIndex of
        0: Add('  AND CLI_STATUS = "A"');
        1: Add('  AND CLI_STATUS = "I"');
      end;

      If (Not fEmptyStr(edtCodVendedor.Text)) And blnLiberado Then
      Begin
        If SameText(fCfgSis('TELVRP'), '1') Then
        Begin
          Add(fStrLocate(edtCodVendedor,arrVendedor,'CLI_CODVEN','CLI_CODVEN'));
          pSetaParam(edtCodVendedor.Text,arrVendedor,strVendedor,'CLI_CODVEN',qryConsulta);
        End
        Else
        Begin
          Add(fStrLocate(edtCodVendedor,arrVendedor,'CLI_CODREP','CLI_CODREP'));
          pSetaParam(edtCodVendedor.Text,arrVendedor,strVendedor,'CLI_CODREP',qryConsulta);
        End;
      End
      Else If Not fEmptyStr(edtCodVendedor.Text) Then
      Begin
        If SameText(fCfgSis('TELVRP'), '1') Then
        Begin
          Add(fStrLocate(edtCodVendedor,arrVendedor,'CLI_CODVEN','CLI_CODVEN'));
          pSetaParam(strCodVen,arrVendedor,strVendedor,'CLI_CODVEN',qryConsulta);
        End
        Else
        Begin
          Add(fStrLocate(edtCodVendedor,arrVendedor,'CLI_CODREP','CLI_CODREP'));
          pSetaParam(strCodVen,arrVendedor,strVendedor,'CLI_CODREP',qryConsulta);
        End;
      End;

      Open;

      pSetaClient(qryConsulta);

      cdsConsulta.Open;

      Case tagTipAge Of
        taManual   : For intIndex := 0 to cxGridAgendamentoDBView.ColumnCount - 1 do
                     Begin
                       if SameText(cxGridAgendamentoDBView.Columns[intIndex].DataBinding.FieldName,'AGE_DTAAGE') Then
                         cxGridAgendamentoDBView.Columns[intIndex].DataBinding.Field.EditMask := '!99/99/9999;1;_';
                     End;
      End;

      Result := True;
    End;

  Except
    Result := False;
  End;
End;

procedure TfrmAgendamentoCiclicoComDia.pVerdeVermelho(edtCodigo: TEditFocus; Shape: TShape);
Begin
  If (Not blnLiberado) Then
  Begin
    edtCodigo.MaxLength := 10;
    edtCodigo.TamCampo  := 10;
    edtCodigo.CompZeros := False;
    edtCodigo.PasswordChar := '*';
    edtCodigo.TipoTexto := ttAlfanumerico;
    Shape.Brush.Color  := clRed;
  End
  Else
  Begin
    Shape.Brush.Color  := clGreen;
  End;
End;

procedure TfrmAgendamentoCiclicoComDia.FormShow(Sender: TObject);
Var
  intIndex: Integer;
begin

  btnCadCli.Visible := fVerificaAcessoSistema('frmCadClientes');
  blnLiberado := fVerificaAcessoSistema('GERAGM');
  strCodVen := '';

  pVerdeVermelho(edtCodVendedor, shpVen);

  inherited;

  btnMarDes.Visible      := IIF(tagTipAge = taManual, True, False);
  btnMarDesTodos.Visible := IIF(tagTipAge = taManual, True, False);
  btnAltData.Visible     := IIF(tagTipAge = taManual, True, False);

  Case tagTipAge Of
    taDiaInicio,
    taAutomatico: Begin
                    Case taDiaInicio Of
                      taDiaInicio : Caption := 'Agendamento cíclico com dia de início de ciclo';
                      taAutomatico: Caption := 'Agendamento Automático';
                    End;

                    For intIndex := 0 to cxGridAgendamentoDBView.ColumnCount - 1 do
                    Begin
                      if SameText(cxGridAgendamentoDBView.Columns[intIndex].DataBinding.FieldName,'AGE_DTABAI') Or
                         SameText(cxGridAgendamentoDBView.Columns[intIndex].DataBinding.FieldName,'AGE_DTAAGE') Then
                        cxGridAgendamentoDBView.Columns[intIndex].Visible := False;

                      if SameText(cxGridAgendamentoDBView.Columns[intIndex].DataBinding.FieldName,'CLI_NOMCLI') Then
                        cxGridAgendamentoDBView.Columns[intIndex].Width := 241;

                      if SameText(cxGridAgendamentoDBView.Columns[intIndex].DataBinding.FieldName,'ATI_DESATI') Then
                        cxGridAgendamentoDBView.Columns[intIndex].Width := 143;
                    End;
                  End;

    taContinuo : Begin
                   Caption := 'Agendamento cíclico contínuo';
                   For intIndex := 0 to cxGridAgendamentoDBView.ColumnCount - 1 do
                   Begin
                     if SameText(cxGridAgendamentoDBView.Columns[intIndex].DataBinding.FieldName,'CLI_INICIC') Or
                        SameText(cxGridAgendamentoDBView.Columns[intIndex].DataBinding.FieldName,'AGE_DTABAI') Or
                        SameText(cxGridAgendamentoDBView.Columns[intIndex].DataBinding.FieldName,'AGE_DTAAGE') Then
                       cxGridAgendamentoDBView.Columns[intIndex].Visible := FALSE;

                     if SameText(cxGridAgendamentoDBView.Columns[intIndex].DataBinding.FieldName,'CLI_NOMCLI') Then
                       cxGridAgendamentoDBView.Columns[intIndex].Width := 241;

                     if SameText(cxGridAgendamentoDBView.Columns[intIndex].DataBinding.FieldName,'ATI_DESATI') Then
                       cxGridAgendamentoDBView.Columns[intIndex].Width := 143;
                   End;

                   self.Width := self.Width - 35;
                 End;

    taManual   : Begin
                   Caption := 'Agendamento manual';
                   For intIndex := 0 to cxGridAgendamentoDBView.ColumnCount - 1 do
                   Begin
                     if SameText(cxGridAgendamentoDBView.Columns[intIndex].DataBinding.FieldName,'CLI_INICIC') Or
                        SameText(cxGridAgendamentoDBView.Columns[intIndex].DataBinding.FieldName,'CLI_INTERV') Then
                       cxGridAgendamentoDBView.Columns[intIndex].Visible := FALSE;
                   End;
                 End;
  End;

end;

procedure TfrmAgendamentoCiclicoComDia.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  Case Key Of
    VK_F6 : If btnMarDes.Enabled And btnMarDes.Visible Then
              btnMarDes.Click;
    VK_F7 : If btnMarDesTodos.Enabled And btnMarDesTodos.Visible Then
              btnMarDesTodos.Click;
    VK_F8 : If btnAltData.Enabled And btnAltData.Visible Then
              btnAltData.Click;
    VK_F9 : If btnCadCli.Enabled And btnCadCli.Visible Then
              btnCadCli.Click;
    VK_F10 : If btnVendasCliente.Enabled And btnVendasCliente.Visible Then
              btnVendasCliente.Click;
  End;
end;

procedure TfrmAgendamentoCiclicoComDia.FormCreate(Sender: TObject);
begin
  inherited;
  {**********************************}
  { VENDEDOR OU REPRESENTANTE        }
  {*******************************RV*}
  If (fCfgSis('TELVRP') = '1') Then
  Begin
    strVenRep         := 'Vendedor';
    lblVenRep.Caption := 'Vendedor:';
    cxGridAgendamentoDBView.Columns[0].Caption := 'Vendedor';
  End
  Else
  Begin
    strVenRep         := 'Representante';
    lblVenRep.Caption := 'Representante:';
    cxGridAgendamentoDBView.Columns[0].Caption := 'Repres.';
  End;
  pSetFocus(edtCodVendedor);
end;

procedure TfrmAgendamentoCiclicoComDia.dbgAgendamentoDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
{  inherited;
  If cdsConsulta.FieldByName('MARDES').AsInteger = 1 Then
  Begin
    dbgAgendamento.Canvas.Brush.Color := clBlue;
    dbgAgendamento.Canvas.Font.Color := clWhite;
  End
  Else If Column.Index = lflLastField.intIndCol then
  Begin
    dbgAgendamento.Canvas.Brush.Color:= clInfoBk;
    dbgAgendamento.Canvas.Font.Color:= clWindowText;
    dbgAgendamento.Canvas.FillRect(Rect);
    dbgAgendamento.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End
  Else
  Begin
    dbgAgendamento.Canvas.Brush.Color := clWhite;
    dbgAgendamento.Canvas.Font.Color := clBlack;
  End;

  dbgAgendamento.DefaultDrawColumnCell(Rect, DataCol, Column, State);}
end;

procedure TfrmAgendamentoCiclicoComDia.dtsConsultaDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  If cdsConsulta.State in [dsInsert, dsEdit] Then
  Begin
    btnMarDes.Enabled      := False;
    btnMarDesTodos.Enabled := False;
    btnAltData.Enabled     := False;
    btnCadCli.Enabled      := False;
  End
  Else
  Begin
    btnMarDes.Enabled      := True;
    btnMarDesTodos.Enabled := True;
    btnAltData.Enabled     := True;
    btnCadCli.Enabled      := True;
  End;
end;

procedure TfrmAgendamentoCiclicoComDia.cdsConsultaAfterInsert(
  DataSet: TDataSet);
begin
  inherited;
  DataSet.Cancel;
end;

procedure TfrmAgendamentoCiclicoComDia.btnAltDataClick(Sender: TObject);
Var
  dtaProximoAgendamento: TDateTime;
  intRecNo: Integer;
begin
  intRecNo := 0;

  If cdsConsulta.IsEmpty Then
    Exit;

  try
    cdsConsulta.DisableControls;
    intRecNo := cdsConsulta.RecNo;

    If Not cdsConsulta.Locate('MARDES', 1, []) Then
    Begin
      fMensagem('', strRegistroNaoSelecionado, ['&O k']);
      Exit;
    End;

    dtaProximoAgendamento := 0;

    If TfrmDigDataMsk.fDigDataMsk(dtaProximoAgendamento, 'Próximo agendamento', 'Data:', VS_Date) Then
    Begin
      If dtaProximoAgendamento < VS_Date Then
      Begin
        fMensagem('ATENÇÃO!', strDataDeAgendamentoMaiorOuIgualHoje, ['&Ok']);
        Exit;
      End;

      cdsConsulta.First;
      While Not cdsConsulta.Eof Do
      Begin

        {Desativar Filtros}
        cxGridAgendamentoDBView.DataController.Filter.Clear;

        If cdsConsulta.FieldByName('MARDES').AsInteger = 1 Then
        Begin
          cdsConsulta.Edit;
          cdsConsulta.FieldByName('AGE_DTAAGE').AsDateTime := dtaProximoAgendamento;
          cdsConsulta.Post;
        End;

        cdsConsulta.Next;

      End;

    End;
  finally
    pSetDataSetRecNo(cdsConsulta, intRecNo);
    cdsConsulta.EnableControls;
  end;
end;

procedure TfrmAgendamentoCiclicoComDia.btnCadCliClick(Sender: TObject);
begin
  inherited;
  If (cdsConsulta.Active) And (Not fEmptyStr(cdsConsulta.FieldByName('CLI_CODCLI').AsString)) Then
  Begin
    Try
      pCriarFormularios(TfrmCadClientes, frmCadClientes);
      frmCadClientes.strCodClienteIniciarCadastro := cdsConsulta.FieldByName('CLI_CODCLI').AsString;
      frmCadClientes.ShowModal;
    Finally
      pFreeAndNil(frmCadClientes);
    End;
  End
  Else
    fMensagem('ATENÇÃO!', 'Para acessar o Cadastro de Clientes, por favor, selecione um registro.', ['&Ok']);
end;

procedure TfrmAgendamentoCiclicoComDia.btnMarDesClick(Sender: TObject);
begin

  If cdsConsulta.IsEmpty Then
    Exit;

  cdsConsulta.AfterPost := nil;
  cdsConsulta.BeforePost := nil;

  try
    cdsConsulta.Edit;
    cdsConsulta.FieldByName('MARDES').AsInteger := IIF(cdsConsulta.FieldByName('MARDES').AsInteger = 1, 0, 1);
    cdsConsulta.Post;
  finally
    cdsConsulta.AfterPost := cdsConsultaAfterPost;
    cdsConsulta.BeforePost := cdsConsultaBeforePost;
  end;

end;

procedure TfrmAgendamentoCiclicoComDia.btnMarDesTodosClick(Sender: TObject);
Var
  intMarDes: Integer;
  bmPosicaoInicialDoProcesso : TBookmark;
begin
  If cdsConsulta.IsEmpty Then
    Exit;

  cdsConsulta.DisableControls;

  bmPosicaoInicialDoProcesso := cdsConsulta.GetBookMark;
  intMarDes                  := IIF(cdsConsulta.FieldByName('MARDES').AsInteger = 1, 0, 1);

  cdsConsulta.DisableControls;
  cdsConsulta.AfterPost := nil;
  cdsConsulta.BeforePost := nil;
  cdsConsulta.First;
  try
    While Not cdsConsulta.Eof Do
    Begin
      cdsConsulta.Edit;
      cdsConsulta.FieldByName('MARDES').AsInteger := intMarDes;
      cdsConsulta.Post;
      cdsConsulta.Next;
    End;
  finally
    cdsConsulta.AfterPost := cdsConsultaAfterPost;
    cdsConsulta.BeforePost := cdsConsultaBeforePost;
    cdsConsulta.EnableControls;
  end;

  cdsConsulta.GotoBookMark(bmPosicaoInicialDoProcesso);
  cdsConsulta.FreeBookMark(bmPosicaoInicialDoProcesso);
  cdsConsulta.EnableControls;

end;

procedure TfrmAgendamentoCiclicoComDia.btnVendasClienteClick(Sender: TObject);
begin
  inherited;

  If Not cdsConsulta.IsEmpty Then
  Begin
    Try
      pCriarFormularios(TfrmRelFatVendasCliente,frmRelFatVendasCliente);
      frmRelFatVendasCliente.blnFaturamento         := true;
      frmRelFatVendasCliente.blnSenha               := False;
      frmRelFatVendasCliente.blnVeioDoTelemarketing := true;
      frmRelFatVendasCliente.blnVeioDoTablet        := false;
      frmRelFatVendasCliente.edtCodCliente.Text     := cdsConsulta.FieldByName('CLI_CODCLI').AsString;
      frmRelFatVendasCliente.edtDesCliente.Text     := cdsConsulta.FieldByName('CLI_NOMCLI').AsString;
      frmRelFatVendasCliente.blnSomenteVendas       := true;
      frmRelFatVendasCliente.blnVeioTelaVendas      := false;

      If Not fClienteConsumidor(cdsConsulta.FieldByName('CLI_NOMCLI').AsString, False, True) Then
      Begin
        frmRelFatVendasCliente.blnCliCons := False;
      End
      Else
      Begin
        frmRelFatVendasCliente.blnCliCons := True;
      End;

      frmRelFatVendasCliente.ShowModal;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[btnVenCliClick]');
      End;
    End;

    pFreeAndNil(frmRelFatVendasCliente);
  End;

end;

function TfrmAgendamentoCiclicoComDia.fAtualizaCliente(DataSet: TDataSet): Boolean;
Var
  qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;

    With qryGen, Sql Do
    Begin
      Clear;
      Add('UPDATE CADCLI           ');
      Add('SET                     ');
      Add('  CLI_INICIC = :INICIC, ');
      Add('  CLI_INTERV = :INTERV  ');
      Add('WHERE                   ');
      Add('  CLI_CODCLI = :CODCLI  ');

      ParamByName('INICIC').AsInteger := DataSet.fieldByName('CLI_INICIC').AsInteger;
      ParamByName('INTERV').AsInteger := DataSet.fieldByName('CLI_INTERV').AsInteger;
      If ParamByName('INICIC').AsInteger = 0 Then
        ParamByName('INICIC').Clear;
      If ParamByName('INTERV').AsInteger = 0 Then
        ParamByName('INTERV').Clear;

      ParamByName('CODCLI').AsString  := DataSet.fieldByName('CLI_CODCLI').AsString;

      ExecSQL;
    End;
    Result := True;

  Except
    Result := False;
  End;

  FreeAndNil(qryGen);
End;

function TfrmAgendamentoCiclicoComDia.fAtualizaAgendamento(DataSet: TDataSet): Boolean;
Var
  qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;

    With qryGen, Sql Do
    Begin
      Clear;
      Add('SELECT                             ');
      Add('  AUTOINCREM, AGE_DTAAGE           ');
      Add('FROM                               ');
      Add('  AGETEL                           ');
      Add('WHERE                              ');
      Add('  AGE_CODCLI = :CODCLI AND         ');
      Add('  AGE_CODEMP = :CODEMP AND         ');
      Add('  AGE_DTABAI IS NULL AND           ');
      Add('  AGE_DTAAGE >= '+QuotedStr(FormatDateTime('yyyy-mm-dd',VS_Date)));
      Add('ORDER BY AGE_DTAAGE                ');
      Add('LIMIT 1                            ');

      ParamByName('CODCLI').AsString  := DataSet.fieldByName('CLI_CODCLI').AsString;
      ParamByName('CODEMP').AsString  := VS_strCodEmp;

      Open;

      If IsEmpty Then
      Begin
        Close;
        Clear;
        Add('INSERT INTO AGETEL                                                                               ');
        Add('(AUTOINCREM, AGE_CODEMP, AGE_CODVEN, AGE_CODCLI, AGE_DTAAGE, AGE_DTABAI, AGE_HORBAI, AGE_OBSERV) ');
        Add('VALUES                                                                                           ');
        Add('(:AUTOIN, :CODEMP, :CODVEN, :CODCLI, :DTAAGE, NULL, NULL, NULL)                                  ');

        ParamByName('AUTOIN').AsString   := fRetAutoIncrem('AGETEL',VS_strCodEmp);
        ParamByName('CODEMP').AsString   := VS_strCodEmp;
        ParamByName('CODVEN').AsString   := DataSet.fieldByName('CLI_CODVEN').AsString;
        ParamByName('CODCLI').AsString   := DataSet.fieldByName('CLI_CODCLI').AsString;
        ParamByName('DTAAGE').AsDate     := DataSet.fieldByName('AGE_DTAAGE').AsDateTime;

        ExecSQL;
        Close;
      End
      Else
      Begin
        Edit;
        FieldByName('AGE_DTAAGE').AsDateTime := DataSet.FieldByName('AGE_DTAAGE').AsDateTime;
        Post;
        Close;
      End;
    End;
    Result := True;

  Except
    Result := False;
  End;

  FreeAndNil(qryGen);
End;

procedure TfrmAgendamentoCiclicoComDia.cdsConsultaAfterPost(
  DataSet: TDataSet);
begin
  inherited;

  Case tagTipAge Of
    taDiaInicio,
    taContinuo,
    taAutomatico : fAtualizaCliente(DataSet);
  End;

end;

procedure TfrmAgendamentoCiclicoComDia.FormResize(Sender: TObject);
begin
  inherited;
  btnSair.Left := pnlBotoes.ClientWidth - btnSair.Width - 3;
end;

procedure TfrmAgendamentoCiclicoComDia.cdsConsultaBeforePost(
  DataSet: TDataSet);
begin
  inherited;

  Case tagTipAge Of
    taDiaInicio,
    taAutomatico: Begin
                    If DataSet.FieldByName('CLI_INICIC').AsInteger < 0 Then
                    Begin
                      fMensagem('ATENÇÃO!', strInicioDoCiclo, ['&Ok']);
                      If (ActiveControl) <> cxGridAgendamento Then
                        pSetFocus(cxGridAgendamento);
                      Abort;
                      Exit;
                    End;

                    If DataSet.FieldByName('CLI_INTERV').AsInteger < 0 Then
                    Begin
                      fMensagem('ATENÇÃO!', strIntervaloMaiorQueZero, ['&Ok']);
                      If (ActiveControl) <> cxGridAgendamento Then
                        pSetFocus(cxGridAgendamento);
                      Abort;
                      Exit;
                    End;

                    If DataSet.FieldByName('CLI_INICIC').AsInteger > 0 Then
                    Begin
                      If Not (DataSet.FieldByName('CLI_INICIC').AsInteger in [1..31])  Then
                      Begin
                        fMensagem('ATENÇÃO!', strInicioDoCiclo, ['&Ok']);
                        If (ActiveControl) <> cxGridAgendamento Then
                          pSetFocus(cxGridAgendamento);
                        Abort;
                        Exit;
                      End
                      Else If DataSet.FieldByName('CLI_INTERV').AsInteger = 0 Then
                      Begin
                        fMensagem('ATENÇÃO!', strIntervaloMaiorQueZero, ['&Ok']);
                        If (ActiveControl) <> cxGridAgendamento Then
                          pSetFocus(cxGridAgendamento);
                        Abort;
                        Exit;
                      End
                    End;

                    If DataSet.FieldByName('CLI_INTERV').AsInteger > 0 Then
                    Begin
                      Case tagTipAge Of
                        taDiaInicio: If DataSet.FieldByName('CLI_INICIC').AsInteger = 0 Then
                                     Begin
                                       fMensagem('ATENÇÃO!', strInicioDoCiclo, ['&Ok']);
                                       If (ActiveControl) <> cxGridAgendamento Then
                                         pSetFocus(cxGridAgendamento);
                                       Abort;
                                       Exit;
                                     End;

                        taAutomatico: If DataSet.FieldByName('CLI_INICIC').AsInteger < 0 Then
                                      Begin
                                        fMensagem('ATENÇÃO!', strInicioDoCiclo, ['&Ok']);
                                        If (ActiveControl) <> cxGridAgendamento Then
                                          pSetFocus(cxGridAgendamento);
                                        Abort;
                                        Exit;
                                      End;
                      End;
                    End;

                    If DataSet.FieldByName('CLI_INICIC').AsInteger = 0 Then
                      DataSet.FieldByName('CLI_INICIC').Clear;

                    If DataSet.FieldByName('CLI_INTERV').AsInteger = 0 Then
                      DataSet.FieldByName('CLI_INTERV').Clear;

                  End;

    taContinuo: Begin

                  If DataSet.FieldByName('CLI_INTERV').AsInteger < 0 Then
                  Begin
                    fMensagem('ATENÇÃO!', strIntervaloMaiorOuIgualAZero, ['&Ok']);
                    If (ActiveControl) <> cxGridAgendamento Then
                      pSetFocus(cxGridAgendamento);
                    Abort;
                    Exit;
                  End;

                  If DataSet.FieldByName('CLI_INICIC').AsInteger = 0 Then
                    DataSet.FieldByName('CLI_INICIC').Clear;

                  If DataSet.FieldByName('CLI_INTERV').AsInteger = 0 Then
                    DataSet.FieldByName('CLI_INTERV').Clear;

                End;

    taManual: Begin

                if not fEmptyStr(AnsiReplaceStr( cdsConsulta.FieldByName('AGE_DTAAGE').AsString, '/','' ) ) then
                Begin
                  if not fValidaDataStr(cdsConsulta.FieldByName('AGE_DTAAGE').AsString ) then
                  Begin
                    fMensagem('ATENÇÃO!', strDataDeAgendamentoInvalida, ['&Ok']);
                    If (ActiveControl) <> cxGridAgendamento Then
                      pSetFocus(cxGridAgendamento);
                    Abort;
                    Exit;
                  End;

                  If DataSet.FieldByName('AGE_DTAAGE').AsDateTime < VS_Date Then
                  Begin
                    fMensagem('ATENÇÃO!', strDataDeAgendamentoMaiorOuIgualHoje, ['&Ok']);
                    If (ActiveControl) <> cxGridAgendamento Then
                      pSetFocus(cxGridAgendamento);
                    Abort;
                    Exit;
                  End
                End;

                fAtualizaAgendamento(DataSet);

              End;
  End;
end;

procedure TfrmAgendamentoCiclicoComDia.cxGridAgendamentoDBViewCellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  If btnMarDes.Visible Then
    btnMarDes.Click;
end;

procedure TfrmAgendamentoCiclicoComDia.cxGridAgendamentoDBViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
begin
  If (Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxGridAgendamentoMARDES.Index] = 1) Then
    ACanvas.Font.Color := clBlue
  Else
    ACanvas.Font.Color := clBlack;
end;

procedure TfrmAgendamentoCiclicoComDia.cxGridAgendamentoDBViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = VK_Escape Then
  Begin
    If cdsConsulta.Active Then
    Begin
      pSetFocus(edtCodVendedor);
      Exit;
    End;
    Close;
  End
  Else If Key = VK_RETURN Then
  Begin
    If btnMarDes.Visible Then
      btnMarDes.Click;
  End;
end;

procedure TfrmAgendamentoCiclicoComDia.edtCodVendedorEnter(
  Sender: TObject);
begin
  inherited;
  If cdsConsulta.State in [dsInsert, dsEdit] Then
    cdsConsulta.Post;
end;

procedure TfrmAgendamentoCiclicoComDia.ApplicationEventsException(
  Sender: TObject; E: Exception);
begin
  inherited;

  If Pos(Uppercase('is not a valid date'),Uppercase(E.Message)) > 0 Then
  Begin
    If fEmptyStr(fTiraCaracEspeciais(cdsConsulta.fieldByName('AGE_DTAAGE').AsString)) Then
    Begin
      cdsConsulta.fieldByName('AGE_DTAAGE').Clear;
      cdsConsulta.Cancel;
    End Else
      fMensagem('', 'Data inválida.', ['&O k']);
  End;

end;

end.

