unit untReqMaterialConsumoEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  DBCtrls, DBEditFocus, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxGridCustomTableView, Math,
  cxGridTableView, cxGridDBTableView, cxClasses, cxControls, cxGridCustomView,
  cxGrid, BitBtnLockedIncrem, QColorLabel, MaskEditFocus, EditFocus,
  untReqMCoDigManual, frxClass, frxExportPDF,
  frxExportHTML, frxExportXLS, frxExportRTF, frxExportTXT, frxDesgn,
  frxDMPExport, frxDBSet, RLFilters, RLDraftFilter, Uni, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog, untTLock;

type
  TfrmReqMaterialConsumoEdit = class(TfrmPaiConfirma)
    pnlDados: TPanel;
    Label2: TLabel;
    cxgMateriais: TcxGrid;
    cxgMateriaisTableView: TcxGridDBTableView;
    cxgMateriaisCODMCO: TcxGridDBColumn;
    cxgMateriaisDESCRI: TcxGridDBColumn;
    cxgMateriaisQTDMCO: TcxGridDBColumn;
    cxgMateriaisUNITAR: TcxGridDBColumn;
    cxgMateriaisTOTMCO: TcxGridDBColumn;
    cxgMateriaisLevel1: TcxGridLevel;
    pnlMaterial: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    dbeCodMco: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    dbeQtdMco: TDBEditFocus;
    dbeUnitar: TDBEditFocus;
    dbeTotMco: TDBEditFocus;
    btnAdicionar: TBitBtnLocked;
    Label1: TLabel;
    Label4: TLabel;
    lblTip_fc: TLabel;
    edtNomForCli: TEditFocus;
    lblDigita: TLabel;
    Label5: TLabel;
    lblObserv: TLabel;
    dtsDetMcoGrid: TDataSource;
    dtsDetMcoEdit: TDataSource;
    dtsGerMco: TDataSource;
    dbeDtaEnt: TDBEditFocus;
    dbeForCli: TDBEditFocus;
    dbeCodDig: TDBEditFocus;
    dbeCodEnt: TDBEditFocus;
    dbeMen001: TDBEditFocus;
    dbeMen002: TDBEditFocus;
    edtNomDig: TEditFocus;
    edtNomEnt: TEditFocus;
    dbeNumReq: TDBEditFocus;
    Label12: TLabel;
    dbeDtaAlt: TDBEditFocus;
    btnExcluir: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure cxgMateriaisEnter(Sender: TObject);
    procedure dbeCodMcoKeyPress(Sender: TObject; var Key: Char);
    procedure dbeForCliKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodEntKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure pnlMaterialEnter(Sender: TObject);
    procedure pnlMaterialExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }

    strKeyLck: String;
    objLock: TLock;

    Function fRetKeyLck: String;
    Function fedtCodMcoKeyPressGer(Sender: TObject; var Key: Char): Boolean;
    Function fCarregaMaterial: Boolean;

    procedure pLigaClients;
    procedure pCalculaTotalMaterial;
    procedure pLimpaDadosMaterial;
    
  public
    { Public declarations }

    objMCODig: TMCOReqMaterial;

  protected

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  end;

var
  frmReqMaterialConsumoEdit: TfrmReqMaterialConsumoEdit;

implementation

uses
  untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmReqMaterialConsumoEdit.btnAdicionarClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
  With objMCODig Do
  Begin
    pSalvaItem;

    If dbeCodMco.CanFocus Then
      pSetFocus(dbeCodMco);
  End;

end;

procedure TfrmReqMaterialConsumoEdit.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  With objMCODig Do
  Begin
    pCancelaEdicaoItem;

    If dbeCodMco.CanFocus Then
      pSetFocus(dbeCodMco);
  End;

end;

procedure TfrmReqMaterialConsumoEdit.btnExcluirClick(Sender: TObject);
begin
  inherited;
  objMCODig.pExcluiItem;
end;

procedure TfrmReqMaterialConsumoEdit.cxgMateriaisEnter(Sender: TObject);
begin
  inherited;

  With objMCODig Do
  Begin
    pCancelaEdicaoItem(opcEditar);
  End;

end;

procedure TfrmReqMaterialConsumoEdit.dbeCodMcoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  fedtCodMcoKeyPressGer(Sender, Key);
end;

procedure TfrmReqMaterialConsumoEdit.dbeCodEntKeyPress(Sender: TObject;
  var Key: Char);
Var
    arrSel: TConsultasArray;

begin
  inherited;
  Try
    if fPesqMotorista(Self, dbeCodEnt, edtNomEnt, Nil, Key, arrSel) then
    Begin
      If fValidaCampos(dbeCodEnt, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  Except
    On E: Exception Do
    Begin
      fMensagem('', 'Erro na busca rápida: ' + E.Message, ['&O k']);
    End;
  End;

end;

procedure TfrmReqMaterialConsumoEdit.dbeForCliKeyPress(Sender: TObject;
  var Key: Char);
Var
    chrKey: Char;
    arrSel: TConsultasArray;

begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    {*********************************}
    {* NOVA CONSULTA DE FORNECEDORES *}
    {******************************CI*}

    chrKey := '/';
    If fPesqFornecedor(conForSimples, Self, dbeForCli, edtNomForCli, Nil, chrKey, arrSel) Then
    Begin
      If fValidaCampos(dbeForCli, True) Then
        SelectNext(ActiveControl, True, True);
    End;
    edtNomForCli.Text := fRetNomFornecedor(dbeForCli.Text);
    Key := #0;
  End;
end;

procedure TfrmReqMaterialConsumoEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  objMCODig.pCancelaEdicaoItem(opcGravar);

  If ModalResult = mrOk Then
  Begin

    If (Not fVerificaCampos) Then
      Action := caNone;

  End;

end;

procedure TfrmReqMaterialConsumoEdit.FormCreate(Sender: TObject);
begin
  inherited;

  strKeyLck      := '';
  objLock   := TLock.Create;
end;

procedure TfrmReqMaterialConsumoEdit.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objLock);
end;

procedure TfrmReqMaterialConsumoEdit.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10   : btnConfirma.Click;

    VK_DELETE: If fCheckParent(ActiveControl, cxgMateriais) Then
                 btnExcluir.Click;

    VK_RETURN: If fCheckParent(ActiveControl, cxgMateriais) And dbeCodMco.CanFocus then
                 pSetFocus(dbeCodMco);
  End;

end;

procedure TfrmReqMaterialConsumoEdit.FormShow(Sender: TObject);
begin
  inherited;
  
  pLigaClients;
  dtsGerMco.DataSet.FieldByName('REQ_CODDIG').AsString := '';
end;

procedure TfrmReqMaterialConsumoEdit.pLigaClients;
Begin
  With objMCODig do
  Begin
    dtsGerMco.DataSet     := zclGerMco;
    dtsDetMcoGrid.DataSet := zclDetMco;
    dtsDetMcoEdit.DataSet := zclDetIns;
    dtsEdits              := dtsDetMcoEdit;
  End;
End;

Function TfrmReqMaterialConsumoEdit.fedtCodMcoKeyPressGer(Sender: TObject;
  var Key: Char): Boolean;
  Var
    arrMco: TConsultasArray;
    qryConMco: TUniQuery;
begin
  If (fEntraCons(Key))         And
     (Not dbeCodMco.ReadOnly)  Then
  Begin
    Try
      qryConMco := fCriaQuery(Self);
      Try
       If fPesqMaterialConsumo(Self, dbeCodMco, Nil, Nil, Key, arrMco) Then
        Begin

          If fValidaCampos(dbeCodMco, True) Then
            SelectNext(ActiveControl, True, True);

        End;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[TfrmReqMaterialConsumoEdit.fedtCodMcoKeyPressGer]');
        End;
      End;

    Finally
      FreeAndNil(qryConMco);
    End;

  End;

  Result := True;

end;

function TfrmReqMaterialConsumoEdit.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
Var
   strCliFor: String;

begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeDtaEnt) Then
    Begin
      Try
        If fEmptyDate(dbeDtaEnt.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A data de entrada deve ser preenchida!', ['&O k']);
          Result := False;
        End

        Else If StrToDate(dbeDtaEnt.Text) > VS_Date Then
        Begin
          pMensagemOk('A data de entrada deve ser menor ou igual a data atual!');
          Result := False;
        End;

      Except
        dbeDtaEnt.Field.Clear;
        fMensagem('', 'Data inválida!', ['&O k']);
        Result := False;
      End;

    End

    {**************************************************}
    {* VALIDA O CAMPO CÓDIGO DO FORNECEDOR / CLIENTE  *}
    {***********************************************CI*}
    Else If (Sender = dbeForCli) Then
    Begin

      If fEmptyStr(dbeForCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do Fornecedor deve ser preenchido!', ['&Ok']);
        Result := False;
      End

      Else
      Begin
        edtNomForCli.Text := fRetNomFornecedor(dbeForCli.Text);

        If fEmptyStr(edtNomForCli.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse ' + strCliFor + ' não está cadastrado!', ['&Ok']);
          Result := False;
        End
        Else If (Not SameText(strKeyLck, fRetKeyLck)) Then
        Begin
          objLock.pDestravarTodos;
          strKeyLck := fRetKeyLck;

          If Not objLock.fLock_Unlock(strKeyLck, True, False) Then
          Begin
            fMensagem('ATENÇÃO!', 'Um documento com os mesmos dados está sendo digitado em outra estação: ' + fGetHostLock(strKeyLck + '%'), ['&Ok']);
            Result := False;
          End
        End;

      End;

    End

    Else If (Sender = dbeCodDig) And (Sender.Parent.Enabled) Then
    Begin

      If fEmptyStr(dbeCodDig.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Digitador deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        edtNomDig.Text := fRetNomeOperador(fRetCodVendedor(dbeCodDig.Text));
        If fEmptyStr(edtNomDig.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Digitador não está cadastrado!', ['&O k']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = dbeCodEnt) Then
    Begin

      edtNomEnt.Text := fRetNomeMotorista(dbeCodEnt.Text);
      If (not fEmptyStr(dbeCodEnt.Text)) And fEmptyStr(edtNomEnt.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Entregador não está cadastrado!', ['&O k']);
        Result := False;
      End;

    End

    Else If dtsDetMcoEdit.DataSet.State In [dsEdit, dsInsert] Then
    Begin

      If (Sender = dbeCodMco) Then
      Begin

        If fEmptyStr(dbeCodMco.Text) Then
        Begin
          pMensagemOk('Informe o código do material!');
          Result := False;
        End Else
        Begin
          dbeDescri.Text := fRetNomeMaterialConsumo(dbeCodMco.Text);

          dtsDetMcoEdit.DataSet.FieldByName('REQ_DESCRI').AsString := dbeDescri.Text;

          If fEmptyStr(dbeDescri.Text) Then
          Begin
            pMensagemOk('Material não econtrado!');
            Result := False;
          End
          Else
          Begin

            If Not fCarregaMaterial Then
            Begin
              pLimpaDadosMaterial;
              Result := False;
            End

            Else If (dtsDetMcoEdit.DataSet.State = dsInsert) And
                     dtsDetMcoGrid.DataSet.Locate('REQ_CODMCO', dbeCodMco.Text, []) Then
            With objMCODig Do
            Begin
              pCancelaEdicaoItem;
              pCancelaEdicaoItem(opcEditar);
            End;

          End;

        End;

      End

      Else If (Sender = dbeQtdMco) Then
      Begin

        If fStrToFloat(dbeQtdMco.Text) <= 0 Then
        Begin
          pMensagemOk('A quantidade deve ser maior que zero!');
          Result := False;
        End

        Else pCalculaTotalMaterial;

      End

      Else If (Sender = dbeUnitar) Then
      Begin

        If fStrToFloat(dbeUnitar.Text) <= 0 Then
        Begin
          pMensagemOk('O valor unitário deve ser maior que zero!');
          Result := False;
        End

        Else pCalculaTotalMaterial;

      End

    End;

  End;

  If (Not Result) And Sender.CanFocus Then
    pSetFocus(Sender);
end;

Function TfrmReqMaterialConsumoEdit.fRetKeyLck: String;
Begin
  Result := 'REQUISICAO_MATCONSUMO_' + dbeNumReq.Text + 'F' + dbeForCli.Text + VS_strCodEmp;
End;

Function TfrmReqMaterialConsumoEdit.fCarregaMaterial: Boolean;
  Var
    strSQL: String;
    qryConMat: TUniQuery;
begin

  Result := True;

  Try

    qryConMat := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  MCO_PRECOM, ';
    strSQL := strSQL + '  MCO_MCOATI ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADMCO ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  MCO_CODMCO = :CODMCO ';

    With qryConMat Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODMCO').AsString := dbeCodMco.Text;
      Open;

      If IsEmpty Then
      Begin
        fMensagem('ATENÇÃO!', 'Material ' + dbeCodMco.Text + ' não está cadastrado!', ['&O k']);
        Result := False;
      End
      Else
      Begin

        If (fStrToFloat(dbeUnitar.Text) <= 0.0) Then
          dbeUnitar.Field.AsFloat := qryConMat.FieldByName('MCO_PRECOM').AsFloat;

        If qryConMat.FieldByName('MCO_MCOATI').AsString <> 'S' Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse material está Inativo!', ['&O k']);
          Result := False;
        End
        Else
          pCalculaTotalMaterial;
          
      End;
    End;
  Except
    On E: Exception Do
    Begin
      FreeAndNil(qryConMat);
      pMensagensErro(E.Message, '');
    End;

  End;

end;

procedure TfrmReqMaterialConsumoEdit.pCalculaTotalMaterial;
Begin
  dbeTotMco.Field.AsFloat := RoundTo(fStrToFloat(dbeUnitar.Text) * fStrToFloat(dbeQtdMco.Text),  -2);
End;

procedure TfrmReqMaterialConsumoEdit.pLimpaDadosMaterial;
  Var
    intContador: Integer;
    edtTemp: TEdit;
    lblTemp: TLabel;
begin

  For intContador := 0 To pnlMaterial.ControlCount -1 Do
  Begin

    If (pnlMaterial.Controls[intContador] Is TEdit) Then
    Begin
      edtTemp := (pnlMaterial.Controls[intContador] As TEdit);
      edtTemp.Clear;
    End
    Else If (pnlMaterial.Controls[intContador] Is TLabel) Then
    Begin
      lblTemp := (pnlMaterial.Controls[intContador] As TLabel);

      If lblTemp.Tag = 99 Then
        lblTemp.Caption := '';

    End;

  End;

  dbeCodMco.Enabled := True;

end;

procedure TfrmReqMaterialConsumoEdit.pnlMaterialEnter(Sender: TObject);
begin
  inherited;
  objMCODig.pEditaItem;
end;

procedure TfrmReqMaterialConsumoEdit.pnlMaterialExit(Sender: TObject);
begin
  inherited;
  objMCODig.pCancelaEdicaoItem;
end;

end.
