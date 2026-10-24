unit untGeraVisitaClienteIndividual;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiOrdenaEdit, Data.DB,
  Datasnap.DBClient, UniClientDataSet, Datasnap.Provider, UniDataSetProvider,
  MemDS, DBAccess, Uni, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, EditFocus, Vcl.Mask, MaskEditFocus,
  Vcl.Grids, Vcl.DBGrids, DBGridCitel, Vcl.ComCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.DBCtrls, DBEditFocus;

type
  TfrmGeraVisitaClienteIndividual = class(TfrmPaiOrdenaEdit)
    edtNumeroLote: TDBEditFocus;
    edtDataCadastro: TDBEditFocus;
    edtCodRepresentante: TDBEditFocus;
    edtDataVisita: TDBEditFocus;
    edtCodCliente: TDBEditFocus;
    edtCodCidade: TDBEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panel1: TPanel;
    BitBtnLocked1: TBitBtnLocked;
    btnPesquisarLote: TBitBtnLocked;
    btnCancelarLote: TBitBtnLocked;
    btnGravarLote: TBitBtnLocked;
    btnIncluirLote: TBitBtnLocked;
    edtNomeRepresentante: TEditFocus;
    edtNomeCliente: TEditFocus;
    edtNomeCidade: TEditFocus;
    btnMoverAcima: TBitBtnLocked;
    btnMoverAbaixo: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure cdsConsultaAfterInsert(DataSet: TDataSet);
    procedure cdsConsultaAfterOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure edtCodRepresentanteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure dbgConsultaTitleClick(Column: TColumn);
    procedure btnMoverAcimaClick(Sender: TObject);
    procedure btnMoverAbaixoClick(Sender: TObject);
    procedure dtsConsultaStateChange(Sender: TObject);
    procedure btnGravarLoteClick(Sender: TObject);
    procedure cdsConsultaReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelarLoteClick(Sender: TObject);
    procedure edtDataVisitaKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirLoteClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPesquisarLoteClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    strCodLote: String;
    strCodRep: String;
    dteDtaCad,
    dteDtaVis: TDate;
    blnValidado: Boolean;
    stlClientes: TStringList;
    procedure pHabilitaBotoesLote;
    procedure pHabilitaBotoesItem;
    function fClienteJaInserido(strCodCli: String): Boolean;
    procedure pAtualizaInseridos();
  protected
    function fGetSql(blnLike: Boolean): String; override;
    function fGetOrderBy: String; override;
    function fSetParametros: Boolean; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untTypesSistema, untConsultas;

procedure TfrmGeraVisitaClienteIndividual.btnCancelaClick(Sender: TObject);
begin
  inherited;
  If stlClientes.IndexOf(cdsConsulta.FieldByName('AGE_CODCLI').AsString) < 0 Then
    stlClientes.Add(cdsConsulta.FieldByName('AGE_CODCLI').AsString)
end;

procedure TfrmGeraVisitaClienteIndividual.btnCancelarLoteClick(Sender: TObject);
begin
  inherited;
  If fMensagem('Confirmação', 'Cancela todas as inclusões e alterações realizadas no lote?', ['&Sim', '&Não'], 2) = 1 Then
    cdsConsulta.CancelUpdates;

  pHabilitaBotoesItem;
  pHabilitaBotoesLote;
  pAtualizaInseridos;
end;

procedure TfrmGeraVisitaClienteIndividual.btnExcluirClick(Sender: TObject);
var
  intIdx: Integer;
begin
  intIdx := stlClientes.IndexOf(cdsConsulta.FieldByName('AGE_CODCLI').AsString);
  If intIdx >= 0 Then
    stlClientes.Delete(intIdx);

  inherited;

  pHabilitaBotoesItem;
  pHabilitaBotoesLote;
end;

procedure TfrmGeraVisitaClienteIndividual.btnGravarLoteClick(Sender: TObject);
var
  dteDtaIns: TDate;
  timHorIns: TTime;
begin
  inherited;
  With cdsConsulta Do
  Begin
    If fEmptyStr(strCodLote) Then
      strCodLote := fAtualizaProCod('AGEVIS', 'AGE_CODLOT');

    dteDtaIns := VS_Date;
    timHorIns := fTime();

    DisableControls;
    Try
      First;

      While Not Eof Do
      Begin
        Edit;
        If fEmptyStr(FieldByName('AUTOINCREM').AsString) Then
          FieldByName('AUTOINCREM').AsString := fRetAutoIncrem(strNomTab, VS_strCodEmp);
        If fEmptyStr(FieldByName('AGE_CODLOT').AsString) Then
          FieldByName('AGE_CODLOT').AsString := strCodLote;
        FieldByName('AGE_INDCOL').AsString := 'I';
        FieldByName('AGE_DTAINS').AsDateTime := dteDtaIns;
        FieldByName('AGE_HORINS').AsDateTime := timHorIns;
        Post;

        Next;
      End;
      ApplyUpdates(0);

      fAbreConsulta;
      pAtualizaInseridos;

      pHabilitaBotoesItem;
      pHabilitaBotoesLote;
    Finally
      EnableControls;
    End;
  End;
end;

procedure TfrmGeraVisitaClienteIndividual.btnAlterarClick(Sender: TObject);
var
  intIdx: Integer;
begin
  intIdx := stlClientes.IndexOf(cdsConsulta.FieldByName('AGE_CODCLI').AsString);
  If intIdx >= 0 Then
    stlClientes.Delete(intIdx);

  inherited;

  if cdsConsulta.RecordCount > 1 Then
  Begin
    edtCodRepresentante.Enabled := False;
    edtDataCadastro.Enabled := False;
    pSetFocus(edtCodCliente);
  End;
end;

procedure TfrmGeraVisitaClienteIndividual.btnGravarClick(Sender: TObject);
begin
  inherited;
  strCodRep := cdsConsulta.FieldByName('AGE_CODREP').AsString;
  dteDtaCad := cdsConsulta.FieldByName('AGE_DTACAD').AsDateTime;
  dteDtaVis := cdsConsulta.FieldByName('AGE_DTAVIS').AsDateTime;

  If stlClientes.IndexOf(cdsConsulta.FieldByName('AGE_CODCLI').AsString) < 0 Then
    stlClientes.Add(cdsConsulta.FieldByName('AGE_CODCLI').AsString)
end;

procedure TfrmGeraVisitaClienteIndividual.btnIncluirClick(Sender: TObject);
begin
  inherited;
  if cdsConsulta.RecordCount > 0 Then
  Begin
    edtCodRepresentante.Enabled := False;
    edtDataCadastro.Enabled := False;
    pSetFocus(edtCodCliente);
  End;
end;

procedure TfrmGeraVisitaClienteIndividual.btnIncluirLoteClick(Sender: TObject);
begin
  inherited;
  strCodLote := '';
  strCodRep  := '';
  dteDtaCad  := 0;
  dteDtaVis  := 0;

  fAbreConsulta;
  pAtualizaInseridos;
  btnIncluir.Click;
end;

procedure TfrmGeraVisitaClienteIndividual.btnMoverAbaixoClick(Sender: TObject);
var
  intAtual, intAbaixo: Integer;
  strAtual: String;
begin
  inherited;

  With cdsConsulta Do
  Begin
    DisableControls;
    Try
      intAtual := FieldByName('AGE_ORDENA').AsInteger;
      strAtual := FieldByName('AGE_CODCLI').AsString;
      Next;
      If not Eof Then
      Begin
        intAbaixo := FieldByName('AGE_ORDENA').AsInteger;

        Edit;
        FieldByName('AGE_ORDENA').AsInteger := intAtual;
        Post;

        If Locate('AGE_CODCLI', strAtual, []) Then
        Begin
          Edit;
          FieldByName('AGE_ORDENA').AsInteger := intAbaixo;
          Post;
        End;
      End;
    Finally
      EnableControls;
    End;
  End;
end;

procedure TfrmGeraVisitaClienteIndividual.btnMoverAcimaClick(Sender: TObject);
var
  intAtual, intAcima: Integer;
  strAtual: String;
begin
  inherited;

  With cdsConsulta Do
  Begin
    DisableControls;
    Try
      intAtual := FieldByName('AGE_ORDENA').AsInteger;
      strAtual := FieldByName('AGE_CODCLI').AsString;
      Prior;
      If not Bof Then
      Begin
        intAcima := FieldByName('AGE_ORDENA').AsInteger;

        Edit;
        FieldByName('AGE_ORDENA').AsInteger := intAtual;
        Post;

        If Locate('AGE_CODCLI', strAtual, []) Then
        Begin
          Edit;
          FieldByName('AGE_ORDENA').AsInteger := intAcima;
          Post;
        End;
      End;
    Finally
      EnableControls;
    End;
  End;
end;

procedure TfrmGeraVisitaClienteIndividual.btnPesquisarLoteClick(
  Sender: TObject);
Var
  strNumLote, strAutoincrem: String;
begin
  inherited;
  If fPesqAgendaVisita(Self, strNumLote, strAutoincrem) Then
  Begin
    strCodLote := strNumLote;
    fAbreConsulta;
    pAtualizaInseridos;
  End;
end;

procedure TfrmGeraVisitaClienteIndividual.cdsConsultaAfterInsert(
  DataSet: TDataSet);
begin
  inherited;
  cdsConsulta.FieldByName('AGE_CODEMP').AsString := VS_strCodEmp;

  If Not fEmptyStr(strCodLote) Then
    cdsConsulta.FieldByName('AGE_CODLOT').AsString := strCodLote;

  If dteDtaCad > 0 Then
    cdsConsulta.FieldByName('AGE_DTACAD').AsDateTime := dteDtaCad
  Else
    cdsConsulta.FieldByName('AGE_DTACAD').AsDateTime := VS_Date;

  If Not fEmptyStr(strCodRep) Then
    cdsConsulta.FieldByName('AGE_CODREP').AsString := strCodRep;

  If dteDtaVis > 0 Then
    cdsConsulta.FieldByName('AGE_DTAVIS').AsDateTime := dteDtaVis;
end;

procedure TfrmGeraVisitaClienteIndividual.cdsConsultaAfterOpen(
  DataSet: TDataSet);
begin
  inherited;
  cdsConsulta.FieldByName('AGE_DTACAD').EditMask := '99/99/9999;1;_';
  cdsConsulta.FieldByName('AGE_DTAVIS').EditMask := '99/99/9999;1;_';
end;

procedure TfrmGeraVisitaClienteIndividual.cdsConsultaAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  edtNomeRepresentante.Text := fRetNomVendRep(edtCodRepresentante.Text);
  edtNomeCliente.Text       := fRetNomCliente(edtCodCliente.Text);
  edtNomeCidade.Text        := fRetNomCidade(edtCodCidade.Text, 0) + '-' +
                               fRetNomCidade(edtCodCidade.Text, 1);
end;

procedure TfrmGeraVisitaClienteIndividual.cdsConsultaReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
  inherited;
  fMensagem('Erro', E.Message, ['&Ok']);
end;

procedure TfrmGeraVisitaClienteIndividual.dbgConsultaTitleClick(
  Column: TColumn);
begin
  //
end;

procedure TfrmGeraVisitaClienteIndividual.dtsConsultaStateChange(
  Sender: TObject);
begin
  inherited;
  pHabilitaBotoesItem;
  pHabilitaBotoesLote;
end;

procedure TfrmGeraVisitaClienteIndividual.edtCodClienteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCliente, edtNomeCliente, Nil, Key, arrClientes, True, Nil, False, edtCodRepresentante.Text) Then
  Begin
    If fValidaCampos(edtCodCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGeraVisitaClienteIndividual.edtCodRepresentanteKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrRep: TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, edtCodRepresentante, edtNomeRepresentante, Nil, Key, arrRep) then
  Begin
    If fValidaCampos(edtCodRepresentante, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmGeraVisitaClienteIndividual.edtDataVisitaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If Key = #13 Then
  Begin
    If blnValidado Then
      btnGravar.Click;

    If blnValidado Then
      btnIncluir.Click;
  End;
end;

function TfrmGeraVisitaClienteIndividual.fClienteJaInserido(strCodCli: String): Boolean;
begin
  Result := stlClientes.IndexOf(strCodCli) >= 0;
end;

function TfrmGeraVisitaClienteIndividual.fGetOrderBy: String;
begin
  Result := ' ORDER BY AGE_ORDENA';
end;

function TfrmGeraVisitaClienteIndividual.fGetSql(blnLike: Boolean): String;
begin
  Result := 'SELECT *, ' +
            '  CONCAT(AGE_CODCLI, "-", CLI_NOMCLI) AS DESCLI, ' +
            '  CONCAT(AGE_CODCID, "-", CID_NOMCID, "-", CID_ESTADO) AS DESCID ' +
            'FROM AGEVIS ' +
            'INNER JOIN CADCLI ' +
            '  ON CLI_CODCLI = AGE_CODCLI ' +
            'INNER JOIN CADCID ' +
            '  ON CID_CODCID = AGE_CODCID ' +
            'WHERE AGE_CODLOT = :CODLOT';
end;

procedure TfrmGeraVisitaClienteIndividual.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If (cdsConsulta.ChangeCount > 0) Then
  Begin
    If fMensagem('Confirmação', 'Cancela todas as inclusões e alterações realizadas no lote?', ['&Sim', '&Não'], 2) = 1 Then
    Begin
      cdsConsulta.CancelUpdates;
      Action := caHide;
    End
    Else
      Action := caNone;
  End
  Else
    Action := caHide;
end;

procedure TfrmGeraVisitaClienteIndividual.FormCreate(Sender: TObject);
begin
  inherited;
  strNomTab := 'AGEVIS';
  strCamChave  := 'AGE_ORDENA';
  blnTemSelecao := False;
  blnSelecionaComEspaco := False;
  blnUsaProxCodVirtual := True;

  blnAutoCommit := False;
  stlClientes := TStringList.Create;
end;

procedure TfrmGeraVisitaClienteIndividual.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(stlClientes);
end;

procedure TfrmGeraVisitaClienteIndividual.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F3) And btnPesquisarLote.Enabled Then
    btnPesquisarLote.Click;

  If (Key = VK_F10) And btnGravarLote.Enabled Then
    btnGravarLote.Click;
end;

procedure TfrmGeraVisitaClienteIndividual.FormShow(Sender: TObject);
begin
  inherited;
  btnPesquisar.Visible := False;
  btnMudaOrdem.Visible := False;
  btnSair.Visible := False;

  blnMudarFoco := True;
  btnIncluir.Click;
end;

function TfrmGeraVisitaClienteIndividual.fSetParametros: Boolean;
begin
  Result := inherited fSetParametros;
  qryConsulta.ParamByName('CODLOT').AsString := strCodLote;
end;

function TfrmGeraVisitaClienteIndividual.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  blnValidado := False;
  Result := True;
  If inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If Sender = edtCodRepresentante Then
    Begin
      If fEmptyStr(edtCodRepresentante.Text) Then
      Begin
        fMensagem('Atenção', 'Informe o código do representante', ['&O k']);
        Result := False;
      End
      Else
      Begin
        edtNomeRepresentante.Text := fRetNomVendRep(edtCodRepresentante.Text);
        If fEmptyStr(edtNomeRepresentante.Text) Then
        Begin
          fMensagem('AVISO','Código do representante não encontrado.', ['&O K']);
          Result := False;
        End;
      End;
    End
    Else If Sender = edtCodCliente Then
    Begin
      If fEmptyStr(edtCodCliente.Text) Then
      Begin
        fMensagem('Atenção', 'Informe o código do cliente', ['&O k']);
        Result := False;
      End
      Else
      Begin
        edtNomeCliente.Text := fRetNomCliente(edtCodCliente.Text);
        If fEmptyStr(edtNomeCliente.Text) Then
        Begin
          fMensagem('AVISO','Código do cliente não encontrado.', ['&O K']);
          Result := False;
        End
        Else If fRetCodRepresCliente(edtCodCliente.Text) <> edtCodRepresentante.Text Then
        Begin
          fMensagem('AVISO','O representante selecionado não é o representante deste cliente.', ['&O K']);
          Result := False;
        End
        Else If fClienteJaInserido(edtCodCliente.Text) Then
        Begin
          fMensagem('AVISO','Este cliente já foi inserido neste lote de visitas.', ['&O K']);
          Result := False;
        End
        Else
        Begin
          edtCodCidade.Text := fRetCidCliente(edtCodCliente.Text);
          edtNomeCidade.Text := fRetNomCidade(edtCodCidade.Text, 0) + '-' +
                                fRetNomCidade(edtCodCidade.Text, 1);

          If cdsConsulta.State in [dsInsert, dsEdit] Then
          Begin
            cdsConsulta.FieldByName('AGE_CODVEN').AsString := fCampoTabela('CLI_CODVEN', 'CADCLI', ['CLI_CODCLI'], [edtCodCliente.Text]);
            cdsConsulta.FieldByName('DESCLI').AsString := edtCodCliente.Text + '-' +
                                                          edtNomeCliente.Text;
            cdsConsulta.FieldByName('DESCID').AsString := edtCodCidade.Text + '-' +
                                                          edtNomeCidade.Text;
          End;
        End;
      End;
    End
    Else If Sender = edtDataCadastro Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(edtDataCadastro.Text)) Then
      Begin
        fMensagem('', 'O campo Data de cadastro deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If Not fValidaDataStr(edtDataCadastro.Text) Then
      Begin
        fMensagem('', 'O campo Data de cadastro é inválido!', ['&O k']);
        Result := False;
      End;
    End
    Else If Sender = edtDataVisita Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(edtDataVisita.Text)) Then
      Begin
        fMensagem('', 'O campo Data da visita deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If Not fValidaDataStr(edtDataVisita.Text) Then
      Begin
        fMensagem('', 'O campo Data da visita é inválido!', ['&O k']);
        Result := False;
      End
      Else If StrToDate(edtDataVisita.Text) < VS_Date Then
      Begin
        fMensagem('', 'A Data de visita deve ser maior ou igual à data atual!', ['&O k']);
        Result := False;
      End;
    End;
  End;

  blnValidado := Result;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmGeraVisitaClienteIndividual.pAtualizaInseridos;
begin
  With cdsConsulta Do
  Begin
    DisableControls;
    Try
      stlClientes.Clear;
      First;
      While Not Eof Do
      Begin
        stlClientes.Add(FieldByName('AGE_CODCLI').AsString);
        Next;
      End;
    Finally
      EnableControls;
    End;
  End;
end;

procedure TfrmGeraVisitaClienteIndividual.pHabilitaBotoesItem;
begin
  btnMoverAcima.Enabled := (cdsConsulta.State = dsBrowse) And (cdsConsulta.RecordCount > 1);
  btnMoverAbaixo.Enabled := (cdsConsulta.State = dsBrowse) And (cdsConsulta.RecordCount > 1);
end;

procedure TfrmGeraVisitaClienteIndividual.pHabilitaBotoesLote;
begin
  btnIncluirLote.Enabled   := (cdsConsulta.ChangeCount = 0) And (cdsConsulta.State = dsBrowse);
  btnGravarLote.Enabled    := (cdsConsulta.ChangeCount > 0) And (cdsConsulta.State = dsBrowse);
  btnCancelarLote.Enabled  := (cdsConsulta.ChangeCount > 0) And (cdsConsulta.State = dsBrowse);
  btnPesquisarLote.Enabled := (cdsConsulta.ChangeCount = 0) And (cdsConsulta.State = dsBrowse);
end;

end.
