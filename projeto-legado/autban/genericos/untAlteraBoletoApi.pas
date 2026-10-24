unit untAlteraBoletoApi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, Grids, DBGridCitel, DBGrids, Mask, MaskEditFocus, StdCtrls,
  EditFocus, Menus, ComCtrls, Buttons, ExtCtrls, QColorLabel, DB, Uni,
  AppEvnts, MemoFocus, UniClientDataSet, UniDataSetProvider, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, untTypesSistema,untCadRec,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, dxCore, cxDateUtils,cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,cxNavigator, cxDBData,
  cxGridCustomTableView, cxGridTableView,cxGridDBTableView, cxGridLevel, cxClasses,
  cxGridCustomView, cxGrid,System.Generics.Collections,
  cxDataControllerConditionalFormattingRulesManagerDialog,
  cxProgressBar,untGravando,JSON,System.StrUtils, cxMemo,DateUtils, cxCheckBox,
  cxCheckComboBox;

type
  TfrmAlteraBoletoApi = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    pnlBotoesBaixa: TPanel;
    pnlAux2: TPanel;
    btnConfirma: TBitBtnLocked;
    btnSairRotina: TBitBtnLocked;
    btnMarcarTodas: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    dtsCtaRec: TDataSource;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    btnConsultar: TBitBtnLocked;
    rbtDtaVen: TRadioButton;
    rbtDtaEnv: TRadioButton;
    dbgDuplicatasDBTableView1: TcxGridDBTableView;
    dbgDuplicatasLevel1: TcxGridLevel;
    dbgDuplicatas: TcxGrid;
    dbgDuplicatasDBTableViewCTR_NUMDUP: TcxGridDBColumn;
    dbgDuplicatasDBTableViewCTR_CODEMP: TcxGridDBColumn;
    dbgDuplicatasDBTableViewCTR_DTAVEN: TcxGridDBColumn;
    dbgDuplicatasDBTableViewCTR_VALDUP: TcxGridDBColumn;
    FlwpnlBotoesBaixa: TFlowPanel;
    Label4: TLabel;
    edtDesPortador: TEditFocus;
    edtCodPor: TEditFocus;
    dbgDuplicatasDBTableViewCTR_MARDES: TcxGridDBColumn;
    dbgDuplicatasDBTableViewCTR_CODCLI: TcxGridDBColumn;
    dbgDuplicatasDBTableViewCTR_NOSNUM: TcxGridDBColumn;
    dbgDuplicatasDBTableViewCTR_CODPOR: TcxGridDBColumn;
    dbgDuplicatasDBTableViewCTR_DTAENV: TcxGridDBColumn;
    pnlLinhaSepara: TPanel;
    grpLegendaCancelamento: TGroupBox;
    Shape6: TShape;
    Label11: TLabel;
    Shape7: TShape;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    pnlTopo: TPanel;
    btnAjuda: TBitBtnLocked;
    frxAjuda: TfrxReport;
    pnlAlteracoes: TPanel;
    chkcbAlteracoes: TcxCheckComboBox;
    lblAlteracoes: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure btnSairRotinaClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnMarcarTodasClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mskDtaIniPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure edtCodCliExit(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure dbgDuplicatasDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dbgDuplicatasDBTableView1CellDblClick(
      Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorExit(Sender: TObject);
    procedure cxGridDBTableView1CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure cxGridDBColumn10GetCellHint(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; ACellViewInfo: TcxGridTableDataCellViewInfo;
      const AMousePos: TPoint; var AHintText: TCaption;
      var AIsHintMultiLine: Boolean; var AHintTextRect: TRect);
    procedure dbgDuplicatasDBTableViewCTR_CODCLIGetCellHint(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      ACellViewInfo: TcxGridTableDataCellViewInfo; const AMousePos: TPoint;
      var AHintText: TCaption; var AIsHintMultiLine: Boolean;
      var AHintTextRect: TRect);
    procedure btnAjudaClick(Sender: TObject);
    procedure chkcbAlteracoesPropertiesEditValueChanged(Sender: TObject);
  private
    { Private declarations }
    FClientDataSetCadRec: TUniClientDataSet;
    FCloneBoletoMarcados: TUniClientDataSet;

    arrClientes,
    arrPortador : TConsultasArray;
    FCorZebra: Integer;

    FNomeDoBanco,
    FConfig,
    FCodigoDoBanco,
    FDuplicatas,
    FCarteiraCompleta: String;

    FCancelouTodos : Boolean;

    FCarteira: Integer;
    FCancelamento:Boolean;

    FObjetoBanco: TObject;

    qryConEmp: TUniQuery;
    qryConPor: TUniQuery;

    procedure pLimpaDados;
    procedure pSelecionaDuplicata;
    procedure pCarregaPortador;
    function FiltrarCampo(ACondicao: Boolean;ACampo:String): String;
    procedure MarcarTodos;
    procedure DesmarcarTodos;
    procedure pCriaTemporaria;
    procedure AlterarBoletos;
    procedure CancelarBoletos;
    procedure ConfirmaAlteracao;
    procedure ConfirmaCancelamento;
    function BoletoEmProcessamento:Boolean;
    function CarregaDadosRegistroAtual(pgbProgresso: TcxProgressBar = Nil):Boolean;
    function TemAlteracao: Boolean;
    procedure ClonarDuplicatasMarcadas;
    procedure CancelarDuplicatasSelecionadas;
    procedure SetParamTemporaria(ADataSet:TUniQuery);
    function RetornaSelectTemporaria:String;
    function RetornaFiltroPeriodo:String;
    procedure ExibirOpcaoDeAlteracoes;
    function AlteracaoSelecionada(AAlteracao: String): Boolean;

  public
    { Public declarations }
    property NomeDoBanco:      String      read FNomeDoBanco      write FNomeDoBanco;
    property Carteira:         Integer     read FCarteira         write FCarteira;
    property Configuracao:     String      read FConfig           write FConfig;
    property CodigoDoBanco:    String      read FCodigoDoBanco    write FCodigoDoBanco;
    property ObjetoBanco:      TObject     read FObjetoBanco      write FObjetoBanco;
    property Cancelamento:     Boolean     read FCancelamento     write FCancelamento;
    property Duplicatas:       String      read FDuplicatas       write FDuplicatas;
    property CancelouTodos:    Boolean     read FCancelouTodos    write FCancelouTodos;
    property CarteiraCompleta: String      read FCarteiraCompleta write FCarteiraCompleta;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean; Override;
  end;


implementation

uses untFuncoes, untFuncoesSimples, untPesqAux, untConsultas,
     untFuncoesConsulta, untConstantes,untTBancoDoBrasilAPI,
     untFuncAutban, untTBancoSicrediAPI, untTBancoItauAPI,
     untTBancoSicoobApi, untTBancoSantanderAPI, untTBancoInter, 
     untTBancoBradescoAPI;

{$R *.dfm}

function TfrmAlteraBoletoApi.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Try
    Result := True;


    If (Sender = edtCodPor) Then
    Begin
      If (fEmptyStr(edtCodPor.Text)) Then
      Begin
        edtDesPortador.Clear;
      End
      Else
      Begin
        If Not SameText(edtCodPor.Text, '00000') Then
        Begin
          SetLength(arrPortador, 0);
          pCarregaPortador;
          If (qryConPor.FieldByName('POR_CODPOR').IsNull) Then
          Begin
            fMensagem('ATENÇÃO!', 'Portador não está cadastrado!', ['&Ok']);
            Result := False;
          End
          Else If fCfgSis('DACPOR', varBoolean) Then
          Begin
            If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos para este portador!', ['&Ok']);
              Result := False;
            End;
          End
        End;
      End;
    End

    {* DATA INICIAL *}
    Else If Sender = mskDtaIni Then
    Begin
      mskDtaFin.Enabled := True;

      If fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If blnBuscaPorChave Then
          mskDtaFin.Clear;

        mskDtaFin.Enabled := False;
      End;
    End

    {* DATA FINAL *}
    Else If (Sender = mskDtaFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
        Begin
          pMensagemOk('A Data Final deve ser preenchida!');
          Result := False;
        End
        Else If Not fValidaPeriodo(mskDtaIni.Text, mskDtaFin.Text) Then
        Begin
          pMensagemOk('A Data Final deve ser maior ou igual a Data Inicial!');
          Result := False;
        End;
      End;
    End;

  Except
    On E: ExceptionAutCom Do
    Begin
      pMensagemOk(E.Message);
      Result := False;
    End;

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
      Result := False;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmAlteraBoletoApi.BoletoEmProcessamento: Boolean;
  Var
    LHoraRegistro: String;
    LHoraCancelamento : TTime;
begin
  Result := False;

  If FClientDataSetCadRec.FieldByName('CTR_DTACAD').AsDateTime = VS_Date Then
  Begin
    LHoraRegistro := RetornaHorarioRegistroBoleto(FClientDataSetCadRec.FieldByName('AUTOINCREM').AsString);

    If fEmptyStr(LHoraRegistro) Then
      Exit;

    LHoraCancelamento := IncMinute(StrToTime(LHoraRegistro),30);

    If (LHoraCancelamento >= fRetHoraServidor) Then
    Begin
      Result := True;
    End;
  End;
end;

procedure TfrmAlteraBoletoApi.MarcarTodos;
  Var
    LRecNo : Integer;
    LEmProcessamento: Boolean;
    LSemAlteracao: Boolean;
begin
  LRecNo := FClientDataSetCadRec.RecNo;
  FClientDataSetCadRec.DisableControls;
  FClientDataSetCadRec.First;
  LEmProcessamento := False;
  LSemAlteracao := False;

  While Not FClientDataSetCadRec.Eof Do
  Begin

    If BoletoEmProcessamento Then
    Begin
      LEmProcessamento := True;
      FClientDataSetCadRec.Next;
      Continue;
    End;

    If Not TemAlteracao Then
    Begin
      LSemAlteracao := True;
      FClientDataSetCadRec.Next;
      Continue;
    End;


    FClientDataSetCadRec.Edit;
    FClientDataSetCadRec.FieldByName('CTR_MARDES').AsString := 'M';
    FClientDataSetCadRec.Post;
    FClientDataSetCadRec.Next;
  End;

  If LEmProcessamento Then
    pMensagemOk('Há boleto(s) não selecionados porque estão em processamento (registrado há menos de 30 minutos)');

  If LSemAlteracao Then
    pMensagemOk('Há boleto(s) não selecionados porque não possuem alterações entre os dados registrados e os dados atuais!');


  FClientDataSetCadRec.RecNo := LRecNo;
  FClientDataSetCadRec.EnableControls;

end;

procedure TfrmAlteraBoletoApi.DesmarcarTodos;
  Var
    LRecNo : Integer;
begin
  LRecNo := FClientDataSetCadRec.RecNo;
  FClientDataSetCadRec.DisableControls;
  FClientDataSetCadRec.First;

  While Not FClientDataSetCadRec.Eof Do
  Begin
    FClientDataSetCadRec.Edit;
    FClientDataSetCadRec.FieldByName('CTR_MARDES').AsString := 'D';
    FClientDataSetCadRec.Post;
    FClientDataSetCadRec.Next;
  End;

  FClientDataSetCadRec.RecNo := LRecNo;
  FClientDataSetCadRec.EnableControls;
end;

procedure TfrmAlteraBoletoApi.mskDtaIniPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;
  If Error Then pMensagemOk('Data Invalida');
end;


procedure TfrmAlteraBoletoApi.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(FObjetoBanco);
  pLimpaDados;
  inherited;
end;

procedure TfrmAlteraBoletoApi.FormCreate(Sender: TObject);
begin
  inherited;
  FClientDataSetCadRec := TUniClientDataSet.Create(Self);
  mskDtaIni.Date := VS_Date;
  mskDtaFin.Date := VS_Date;
  FCorZebra := fCfgSis('CORZEB', varInteger);
  FCancelouTodos := False;
end;

procedure TfrmAlteraBoletoApi.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_Return: If ActiveControl.ClassName = 'TcxGridSite' Then pSelecionaDuplicata;
    VK_Escape: Begin
                 pLimpaDados;
               End;
    VK_F7    : If (btnMarcarTodas.Enabled = True) Then
               Begin
                  btnMarcarTodas.Click;
               End;
    VK_F8    : If (btnDesmarcaTodos.Enabled = True) Then
               Begin
                 btnDesmarcaTodos.Click;
               End;
    VK_F10   : Begin
                 Key := 0;
                 btnConfirma.Click;
               End;
  End;

end;

procedure TfrmAlteraBoletoApi.FormShow(Sender: TObject);
begin
  inherited;
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryConPor := fCriarQuery('SELECT * FROM CADPOR WHERE FALSE', Self);

  If fEmptyStr(FCarteiraCompleta) Then
    FCarteiraCompleta :=  Concat(FConfig, FCarteira.ToString, '-', VS_strCodEmp);

  CancelarDuplicatasSelecionadas;
  ExibirOpcaoDeAlteracoes;

end;

procedure TfrmAlteraBoletoApi.pLimpaDados;
begin

  If Not fEmptyStr(FDuplicatas) Then
  Begin
    btnSairRotina.Click;
    Exit;
  End;

  mskDtaIni.Clear;
  mskDtaFin.Clear;
  edtCodCli.Clear;
  edtNomCli.Clear;
  pSetFocus(edtCodCli);
  FClientDataSetCadRec.Close;
end;

procedure TfrmAlteraBoletoApi.pSelecionaDuplicata;
  Var
    LMarcar :Boolean;
begin

  If (FClientDataSetCadRec.IsEmpty) Then
    Exit;

  Try

    If BoletoEmProcessamento Then
    Begin
      pMensagemOk('Boleto em processamento (registrado há menos de 30 minutos)');
      Exit;
    End;

    If Not TemAlteracao Then
    Begin
      fMensagem('AVISO!', 'Não há alteração entre os dados registrados e os dados atuais!', ['&Ok']);
      Exit;
    End;

    LMarcar := FClientDataSetCadRec.FieldByName('CTR_MARDES').AsString = 'D';

    If Not fEmptyStr(FDuplicatas) Then
    Begin
      If Not LMarcar Then
      Begin
        fMensagem('AVISO!', 'Duplicatas pré-selecionadas em outra rotina não podem ser desmarcadas!', ['&Ok']);
        Exit;
      End;
    End;

    FClientDataSetCadRec.Edit;
    FClientDataSetCadRec.FieldByName('CTR_MARDES').AsString := IIF(LMarcar,'M','D');
    FClientDataSetCadRec.Post;

  Except
    On E: ExceptionAutCom Do pMensagemOk(E.Message);
    On E: Exception Do pMensagensErro(E.Message, '');
  End;

  dbgDuplicatasDBTableView1.DataController.Refresh;
end;

function TfrmAlteraBoletoApi.RetornaFiltroPeriodo: String;
begin
  If rbtDtaVen.Checked Then
    Result := FiltrarCampo(Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)),
                                         'CTR_DTAVEN BETWEEN :DTAINI AND :DTAFIN')
  Else
    Result := FiltrarCampo(Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)),
                                         'CTR_DTAENV BETWEEN :DTAINI AND :DTAFIN');
end;

function TfrmAlteraBoletoApi.RetornaSelectTemporaria: String;
begin
  Result := RetornaSQLCamposTabelasTemporaria(False,'','');
  Result := Result + ' WHERE CTR_DTABAI IS NULL     ';
  Result := Result + '   AND CTR_CARTEI = :CARTEI   ';

  If fEmptyStr(FDuplicatas) Then
  Begin
    Result := Result + FiltrarCampo(Not fEmptyStr(edtCodCli.Text),'CTR_CODCLI = :CODCLI');
    Result := Result + FiltrarCampo(Not fEmptyStr(edtCodPor.Text),'CTR_CODPOR = :CODPOR');
    Result := Result + RetornaFiltroPeriodo;
  End
  Else
    Result := Result + 'AND R.AUTOINCREM IN ( ' + fRetStrToSQLIn(FDuplicatas,',') + ')';
end;

procedure TfrmAlteraBoletoApi.SetParamTemporaria(ADataSet: TUniQuery);
begin
  Try

    ADataSet.ParamByName('CARTEI').AsString := FCarteiraCompleta;

    If Assigned(ADataSet.FindParam('CODCLI')) Then
      ADataSet.ParamByName('CODCLI').AsString := edtCodCli.Text;

    If Assigned(ADataSet.FindParam('CODPOR')) Then
      ADataSet.ParamByName('CODPOR').AsString := edtCodPor.Text;

    If Assigned(ADataSet.FindParam('DTAINI')) Then
    Begin
      ADataSet.ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
      ADataSet.ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
    End;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;

end;

procedure TfrmAlteraBoletoApi.dbgDuplicatasDBTableView1CellDblClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  pSelecionaDuplicata;
end;

procedure TfrmAlteraBoletoApi.dbgDuplicatasDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
    strMarDes: String;
begin
  inherited;
  strMarDes := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasDBTableViewCTR_MARDES.Index]);

  If (FClientDataSetCadRec.IsEmpty) Or fEmptyStr(strMarDes) Then
    Exit;

  If (Not AViewInfo.GridRecord.Focused) And
     (AViewInfo.GridRecord.Index Mod 2 = 0) Then
  Begin
    ACanvas.Brush.Color := FCorZebra;
  End;

  If (strMarDes = 'M') Then
  Begin
    If (Not AViewInfo.Selected) Then
      ACanvas.Font.Color := clBlue
    Else
      ACanvas.Font.Color := clLime;

    Exit;
  End;

end;

procedure TfrmAlteraBoletoApi.dbgDuplicatasDBTableViewCTR_CODCLIGetCellHint(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  ACellViewInfo: TcxGridTableDataCellViewInfo; const AMousePos: TPoint;
  var AHintText: TCaption; var AIsHintMultiLine: Boolean;
  var AHintTextRect: TRect);
begin
  inherited;
  AHintText := VarToStr(ARecord.Values[Sender.Index]);
  AIsHintMultiLine := True;
end;

procedure TfrmAlteraBoletoApi.edtCodCliExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtNomCli, arrClientes, Nil, fRetNomCliente, 'do Cliente');
end;

procedure TfrmAlteraBoletoApi.edtCodCliKeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmAlteraBoletoApi.edtCodPorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPor, edtDesPortador, arrPortador, Nil, fRetNomPortador, 'do Portador');
end;

procedure TfrmAlteraBoletoApi.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  if fPesqPortador(conSimples,
                   Self,
                   edtCodPor,
                   edtDesPortador,
                   nil,
                   Key,
                   arrPortador,
                   False,
                   'Consulta de Portadores',
                   '',
                   False,
                   False) then
  Begin
    If (fValidaCampos(edtCodPor, True)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmAlteraBoletoApi.ExibirOpcaoDeAlteracoes;
begin
  pnlCabecalho.Height := 91;

  If Not MatchStr(FCodigoDoBanco,['001']) Then
    Exit;

  If FCancelamento Then
    Exit;

  pnlCabecalho.Height := 106;
  btnConsultar.Top  := 78;
  pnlAlteracoes.Visible := True;
end;

procedure TfrmAlteraBoletoApi.btnConsultarClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
   TfrmGravando.fExecutarModal(pCriaTemporaria, 'Aguarde... Carregando Títulos.', '');

  If FClientDataSetCadRec.IsEmpty Then
  Begin
    pMensagemOK('Não há boletos registrados para o filtro informado!');
    pSetFocus(edtCodPor);
  End Else pSetFocus(dbgDuplicatas);

end;

procedure TfrmAlteraBoletoApi.btnDesmarcaTodosClick(Sender: TObject);
begin
  If (Not FClientDataSetCadRec.Active) Or (FClientDataSetCadRec.IsEmpty) Then
  begin
    pMensagemOk('É necessário selecionar ao menos uma duplicata!');
    Exit;
  end;

  Try
    TfrmGravando.fExecutarModal(DesmarcarTodos, 'Aguarde... Desmarcando duplicatas.', '');
  Except
    On E: ExceptionAutCom Do pMensagemOk(E.Message);
    On E: Exception Do pMensagensErro(E.Message, '');
  End;

  dbgDuplicatasDBTableView1.DataController.Refresh;
end;

procedure TfrmAlteraBoletoApi.btnMarcarTodasClick(Sender: TObject);
begin
  If (FClientDataSetCadRec.IsEmpty) Then
  begin
    pMensagemOk('É necessário selecionar ao menos uma duplicata!');
    Exit;
  end;

  Try
    TfrmGravando.fExecutarModal(MarcarTodos, 'Aguarde... Marcando duplicatas.', '');

  Except
    On E: ExceptionAutCom Do pMensagemOk(E.Message);
    On E: Exception Do pMensagensErro(E.Message, '');
  End;

  dbgDuplicatasDBTableView1.DataController.Refresh;
end;

procedure TfrmAlteraBoletoApi.btnSairRotinaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmAlteraBoletoApi.CancelarBoletos;
begin
  Try
    Case StrToInt(CodigoDoBanco) Of
        1: TBancoDoBrasilAPI(FObjetoBanco).CancelarBoletos(FCloneBoletoMarcados);
       33: TBancoSantanderAPI(FObjetoBanco).CancelarBoletos(FCloneBoletoMarcados);
       77: TBancoInter(FObjetoBanco).CancelarBoletos(FCloneBoletoMarcados);
      237: TBancoBradescoAPI(FObjetoBanco).CancelarBoletos(FCloneBoletoMarcados);
      341: TBancoItauAPI(FObjetoBanco).CancelarBoletos(FCloneBoletoMarcados);
      748: TBancoSicrediAPI(FObjetoBanco).CancelarBoletos(FCloneBoletoMarcados);
      756: TBancoSicoobAPI(FObjetoBanco).CancelarBoletos(FCloneBoletoMarcados);
    End;

    If (FCloneBoletoMarcados.RecordCount = FClientDataSetCadRec.RecordCount) Then
    Begin
      FCancelouTodos := True;
    End;

  Except
    On E: Exception Do
    Begin
      FCancelouTodos := False;
      pMensagensErro(E.Message,'[TfrmAlteraBoletoApi.CancelarBoletos]');
      Exit;
    End;
  End;
end;

procedure TfrmAlteraBoletoApi.CancelarDuplicatasSelecionadas;
begin
  If fEmptyStr(FDuplicatas) Then
    Exit;

  pnlCabecalho.Visible     := False;
  btnMarcarTodas.Enabled   := False;
  btnDesmarcaTodos.Enabled := False;
  Self.Height := 304;

  btnConsultar.Click;
  btnMarcarTodas.Click;
end;

procedure TfrmAlteraBoletoApi.ConfirmaAlteracao;
  Var
    LGravando: TfrmGravando;
begin
  If (fMensagem('AVISO', 'Confirma a alteração?', ['', '']) = 1) Then
  Begin

    pCriarFormularios(TfrmGravando,LGravando);
    LGravando.fExecutarModal(AlterarBoletos, 'Aguarde... Alterando boleto(s).', '');
    pFreeAndNil(LGravando);
    pLimpaDados;
    pSetFocus(edtCodPor);

  End Else pSetFocus(dbgDuplicatas);
end;

procedure TfrmAlteraBoletoApi.ConfirmaCancelamento;
  Var
    LGravando: TfrmGravando;
begin
  If (fMensagem('AVISO', 'Confirma o cancelamento?', ['', '']) = 1) Then
  Begin
    pCriarFormularios(TfrmGravando,LGravando);
    LGravando.fExecutarModal(CancelarBoletos, 'Aguarde... Cancelando boleto(s).', '');
    pFreeAndNil(LGravando);

    pLimpaDados;
    pSetFocus(edtCodPor);
  End Else pSetFocus(dbgDuplicatas);
end;

procedure TfrmAlteraBoletoApi.cxGridDBColumn10GetCellHint(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  ACellViewInfo: TcxGridTableDataCellViewInfo; const AMousePos: TPoint;
  var AHintText: TCaption; var AIsHintMultiLine: Boolean;
  var AHintTextRect: TRect);
begin
  inherited;
  AHintText := VarToStr(ARecord.Values[Sender.Index]);
  AIsHintMultiLine := True;
end;

procedure TfrmAlteraBoletoApi.cxGridDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If AViewInfo.GridRecord.Focused   Then
  Begin
    ACanvas.Brush.Color :=  clSkyBlue
  End;
end;

function TfrmAlteraBoletoApi.AlteracaoSelecionada(AAlteracao: String): Boolean;
begin
  Result := False;

  If Trim(chkcbAlteracoes.Text).Equals('Todas') Then
    Exit(True);

  If(Pos(AAlteracao,chkcbAlteracoes.Text) > 0) Then
     Exit(True);
end;

procedure TfrmAlteraBoletoApi.AlterarBoletos;
begin
  Try
    If CodigoDoBanco = '001' Then
    Begin
      TBancoDoBrasilAPI(FObjetoBanco).Alteracoes := chkcbAlteracoes.Text;
      TBancoDoBrasilAPI(FObjetoBanco).AlterarBoletos(FCloneBoletoMarcados);
    End
    Else
    If CodigoDoBanco = '748' Then
       TBancoSicrediAPI(FObjetoBanco).AlterarBoletos(FCloneBoletoMarcados);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmAlteraBoletoApi.AlterarBoletos]');
      Exit;
    End;
  End;
end;


procedure TfrmAlteraBoletoApi.ClonarDuplicatasMarcadas;
Begin
  FCloneBoletoMarcados := TUniClientDataSet.Create(Self);

  pCloneDataSet(FCloneBoletoMarcados, FClientDataSetCadRec);
  FCloneBoletoMarcados.Filtered := False;
  FCloneBoletoMarcados.Filter := 'CTR_MARDES = ''M''';
  FCloneBoletoMarcados.Filtered := True;
End;

procedure TfrmAlteraBoletoApi.btnAjudaClick(Sender: TObject);
begin
  inherited;
  pPreviewReport(Self.Name, Self.Caption + ' (Help)',frxAjuda);
end;

procedure TfrmAlteraBoletoApi.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  If Not FClientDataSetCadRec.Active Then
  Begin
    pMensagemOk('Selecione ao menos um registro!');
    Exit;
  End;

  Try
    Try
      Self.Enabled := False;
      ClonarDuplicatasMarcadas;

      If FCloneBoletoMarcados.RecordCount <= 0 Then
      Begin
        pMensagemOk('Selecione ao menos um registro!');
        pSetFocus(dbgDuplicatas);
        Exit;
      End;

      If FCancelamento Then ConfirmaCancelamento
      Else ConfirmaAlteracao;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'TfrmAlteraBoletoApi.btnConfirmaClick');
      End;
    End;
  Finally
    FreeAndNil(FCloneBoletoMarcados) ;
    Self.Enabled := True;
  End;

end;

procedure TfrmAlteraBoletoApi.pCarregaPortador;
begin
  If Not fEmptyStr(edtCodPor.Text) Then
  Begin
    edtDesPortador.Text := fRetNomPortador(edtCodPor.Text);
    pPesquisaCadPor(Nil, qryConPor, edtCodPor.Text);
  End
  Else
    edtDesPortador.Clear;
end;

procedure TfrmAlteraBoletoApi.pCriaTemporaria;
  Var
    LCadRec: TUniQuery;
    LGravando : TfrmGravando;
begin
  Try
    FClientDataSetCadRec.Filter   := '';
    FClientDataSetCadRec.Filtered := False;
    FClientDataSetCadRec.Close;

    LCadRec := fCriaQuery(Self);

    Try
      LCadRec.Close;
      LCadRec.SQL.Clear;
      LCadRec.SQL.Text := RetornaSelectTemporaria;
      SetParamTemporaria(LCadRec);
      LCadRec.Open;

      If Not LCadRec.IsEmpty Then
      Begin
        pSetaClient(LCadRec);
        FClientDataSetCadRec := fCriaClientDatSet(LCadRec);

        FClientDataSetCadRec.Open;
        FClientDataSetCadRec.IndexFieldNames := 'CTR_DTAVEN;CTR_NUMDUP;CTR_CODEMP;CTR_CODCLI';

        TFloatField(FClientDataSetCadRec.FieldByName('CTR_VALDUP')).DisplayFormat := '#,##0.00';
        dtsCtaRec := fCriaDataSource(FClientDataSetCadRec);

        Try
          pCriarFormularios(TfrmGravando,LGravando);
          LGravando.fExecutarAcao := CarregaDadosRegistroAtual;
          LGravando.lblGravando.Caption := 'Aguarde... Carregando dados registrados.';
          LGravando.ShowModal;
        Finally
          pFreeAndNil(LGravando);
        end;

        dbgDuplicatasDBTableView1.DataController.DataSource := dtsCtaRec;
        FClientDataSetCadRec.First;
      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FClientDataSetCadRec.SetProvider(nil);
    FreeAndNil(LCadRec);
  End;
end;

function TfrmAlteraBoletoApi.FiltrarCampo(ACondicao: Boolean;ACampo:String): String;
Begin
  Result := '';

  If Not ACondicao Then
    Exit;

  Result := ' AND ' + ACampo;
End;

function TfrmAlteraBoletoApi.TemAlteracao: Boolean;
begin
  Result := False;

  If FCancelamento Then
    Exit(True);

  If AlteracaoSelecionada('Endereço do Pagador') Then
    If FClientDataSetCadRec.FieldByName('ENDERECO_PAGADOR_REGISTRADO').AsString <>
       FClientDataSetCadRec.FieldByName('ENDERECO_ATUAL_PAGADOR').AsString  Then
      Result := True;

  If AlteracaoSelecionada('Vencimento') Then
    If (FClientDataSetCadRec.FieldByName('VENCIMENTO_REGISTRADO').AsDateTime <>
        FClientDataSetCadRec.FieldByName('CTR_DTAVEN').AsDateTime) Then
      Result := True;

  If MatchStr(FCodigoDoBanco,['001']) Then
  Begin
    If AlteracaoSelecionada('Prazo para recebimento de boleto vencido') Then
      If (FClientDataSetCadRec.FieldByName('QTD_DIAS_RECEBIMENTO_APOS_VENCIMENTO_REGISTRADO').AsString <>
          TBancoDoBrasilAPI(FObjetoBanco).DadosCarteira.QtdDiasLimitePagto) Then
        Result := True;

  End;


end;


function TfrmAlteraBoletoApi.CarregaDadosRegistroAtual(
  pgbProgresso: TcxProgressBar): Boolean;
  Var
    LEndereco,
    LCep,
    LCidade,
    LBairro,
    LUf : String;
    LRegBol : TUniQuery;
begin
  Result := True;

  If FCancelamento Then
    Exit;

  If FClientDataSetCadRec.IsEmpty Then
    Exit;

  Try
    FClientDataSetCadRec.DisableControls;
    FClientDataSetCadRec.First;

    LRegBol := fCriaQuery(Nil);
    LRegBol.Close;
    LRegBol.SQL.Clear;
    LRegBol.SQL.Text := 'SELECT                        '+
                        '  REG_JSOENV,IFNULL(REG_DESCRI,"REGISTRO") AS DESCRICAO '+
                        'FROM                          '+
                        '  REGBOL                      '+
                        'WHERE REG_DUPLIC = :DUPLIC    '+
                        '  AND REG_EXCEPT IS NULL      '+
                        '  AND REG_JSOREC IS NOT NULL  '+
                        '  AND IFNULL(REG_DESCRI,"REGISTRO") IN ("REGISTRO","ALTERAÇÃO") '+
                        'ORDER BY REG_DTAREG,     '+
                        '  REG_HRAREG             ';

    pgbProgresso.Position := 0;
    pgbProgresso.Properties.Max := FClientDataSetCadRec.RecordCount;
    While Not FClientDataSetCadRec.Eof Do
    Begin

      LRegBol.Close;
      LRegBol.ParamByName('DUPLIC').AsString := FClientDataSetCadRec.FieldByName('AUTOINCREM').AsString;
      LRegBol.Open;

      FClientDataSetCadRec.Edit;
      FClientDataSetCadRec.FieldByName('VENCIMENTO_REGISTRADO').AsDateTime     := RetornaDataVencimentoRegistroBoleto(FClientDataSetCadRec.FieldByName('AUTOINCREM').AsString, CodigoDoBanco);
      FClientDataSetCadRec.FieldByName('ENDERECO_PAGADOR_REGISTRADO').AsString := RetornaEnderecoPagadorRegistroBoleto(FClientDataSetCadRec.FieldByName('AUTOINCREM').AsString);
      FClientDataSetCadRec.FieldByName('QTD_DIAS_RECEBIMENTO_APOS_VENCIMENTO_REGISTRADO').AsString := RetornaDiasParaRecebimentoAposVencimetoRegistroBoleto(CodigoDoBanco,LRegBol);

      LEndereco := RetornaValorString(RetornaEnderecoENumeroCom30Caracteres(FClientDataSetCadRec.FieldByName('CLI_ENDERE').AsString,
                                                                            FClientDataSetCadRec.FieldByName('CLI_ENDNUM').AsString));
      LCep    := fRetSomenteNumeros(FClientDataSetCadRec.FieldByName('CLI_C_E_P_').AsString);
      LCidade := RetornaValorString(FClientDataSetCadRec.FieldByName('CID_NOMCID').AsString, 30);
      LBairro := RetornaValorString(FClientDataSetCadRec.FieldByName('CLI_BAIRRO').AsString, 30);
      LUf     :=  FClientDataSetCadRec.FieldByName('CID_ESTADO').AsString;

      FClientDataSetCadRec.FieldByName('ENDERECO_ATUAL_PAGADOR').AsString := Concat(LEndereco,' - ',LBairro,' - ',LCidade ,'/',LUf,' - ',LCep);

      FClientDataSetCadRec.Post;

      pStep(pgbProgresso);
      FClientDataSetCadRec.Next;
    End;
    FClientDataSetCadRec.First;
    FClientDataSetCadRec.EnableControls;
    FreeAndNil(LRegBol);
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

procedure TfrmAlteraBoletoApi.chkcbAlteracoesPropertiesEditValueChanged(
  Sender: TObject);
begin
  inherited;
  If Not FClientDataSetCadRec.IsEmpty Then
    DesmarcarTodos;
end;

end.

