unit untManCadCidadeSigep;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass, cxProgressBar,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ExtCtrls, StrUtils,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, Uni, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxClasses, cxGridLevel,
  cxGrid, EditFocus, Vcl.CheckLst, untZClient, cxCheckBox,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  opcOperacao = (opcMarcar, opcDesmarcar, opcInverter);

  TfrmManCadCidadeSigep = class(TfrmPaiConfirma)
    pnlTop: TPanel;
    pnlButton: TPanel;
    cxgCidadesLevel: TcxGridLevel;
    cxgCidadesTableView: TcxGridDBTableViewCitel;
    cxgCidades: TcxGridCitel;
    edtNomCid: TEditFocus;
    Label1: TLabel;
    clbEstados: TCheckListBox;
    Label2: TLabel;
    btnFiltrar: TBitBtnLocked;
    Label9: TLabel;
    Label10: TLabel;
    edtVrMSeg: TEditFocus;
    edtPerSeg: TEditFocus;
    cxgCidadesTableViewColumn1: TcxGridDBColumn;
    cxgCidadesTableViewColumn2: TcxGridDBColumn;
    cxgCidadesTableViewColumn3: TcxGridDBColumn;
    cxgCidadesTableViewColumn4: TcxGridDBColumn;
    cxgCidadesTableViewColumn5: TcxGridDBColumn;
    cxgCidadesTableViewColumn6: TcxGridDBColumn;
    btnInverter: TBitBtnLocked;
    btnDesmarcarTodos: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    Foperacao : opcOperacao;
    cdsCidades : TZClient;
    function fGetSQL : String;
    function fGetEstados : String;
    procedure pTodos(operacao : opcOperacao);
    function fTodosProgresso(cxProgress : TcxProgressBar):Boolean;
    function fConfirmaeLimpa : Boolean;
    function fConfirmaeLimpaProgresso(cxProgress : TcxProgressBar):Boolean;
  public
  protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean):Boolean; Override;
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples, untGravando;

{ TfrmManCadCidadeSigep }

procedure TfrmManCadCidadeSigep.btnConfirmaClick(Sender: TObject);
begin
  //inherited;
  If not cdsCidades.Active Then
  Begin
    fMensagem('','Filtre o cadastro de cidades antes de efetuar essa operação!', ['&Ok']);
    Exit;
  End;

  Try
    cdsCidades.Filter := 'MARCA = ' + QuotedStr('S');
    cdsCidades.Filtered := True;

    If cdsCidades.RecordCount > 0 Then
    Begin
      If fVerificaCampos Then
        If fMensagem('', 'Deseja atualizar todos os registros marcados?', ['&Sim', '&Não']) = 1 Then
          fConfirmaeLimpa;
    End
    Else
    Begin
      fMensagem('', 'Nenhuma cidade foi selecionada!', ['&OK']);
    End;
  Finally
    cdsCidades.Filtered := False;
    cdsCidades.Filter := '';
  End;
end;

procedure TfrmManCadCidadeSigep.btnFiltrarClick(Sender: TObject);
begin
  inherited;
  With cdsCidades.qryQuery, SQL Do
  Begin
    Close;
    Clear;
    Add( fGetSQL );
    ParamByName('NOMCID').AsString := '%' + edtNomCid.Text + '%';
  End;
  cdsCidades.fAbreClient(True, 'btnFiltrarClick');

  TFloatField(cdsCidades.FieldByName('CID_VRMSEG')).DisplayFormat := '#,#0.00';
  TFloatField(cdsCidades.FieldByName('CID_PERSEG')).DisplayFormat := '#,#0.00';

  pSetFocus(edtVrMSeg);
end;

procedure TfrmManCadCidadeSigep.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;
  If not cdsCidades.Active Then
  Begin
    fMensagem('','Filtre o cadastro de cidades antes de efetuar essa operação!', ['&Ok']);
    Exit;
  End;

  Case TBitBtnLocked(Sender).Tag Of
    0: pTodos( opcMarcar );
    1: pTodos( opcDesmarcar );
    2: pTodos( opcInverter );
  End;
end;

function TfrmManCadCidadeSigep.fConfirmaeLimpa: Boolean;
begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.lblGravando.Caption := 'Atualizando registros...';
    frmGravando.fExecutarAcao := fConfirmaeLimpaProgresso;
    frmGravando.ShowModal;
    Result := frmGravando.blnConfirma;

    if Result Then
      fMensagem('', 'Atualização realizada com sucesso!', ['&OK']);
  Finally
    FreeAndNil(frmGravando);
  End;
end;

function TfrmManCadCidadeSigep.fConfirmaeLimpaProgresso(cxProgress: TcxProgressBar): Boolean;
  Var
    qryUpdate : TUniQuery;
begin
  Try
    Result := True;
    cdsCidades.DisableControls;
    cdsCidades.First;
    cxProgress.Properties.Max := cdsCidades.RecordCount;

    qryUpdate := fCriaQuery;
    With qryUpdate, SQL Do
    Begin
      Close;
      Clear;
      Add(' UPDATE CADCID SET CID_VRMSEG = :VRMSEG, ');
      Add('                   CID_PERSEG = :PERSEG  ');
      Add(' WHERE CID_CODCID = :CODCID              ');

      ParamByName('VRMSEG').AsFloat  := fStrToFloat(edtVrMSeg.Text);
      ParamByName('PERSEG').AsFloat  := fStrToFloat(edtPerSeg.Text);
      While Not cdsCidades.Eof Do
      Begin
        If cdsCidades.FieldByName('MARCA').AsString = 'S' Then
        Begin
          ParamByName('CODCID').AsString := cdsCidades.FieldByName('CID_CODCID').AsString;
          ExecSQL;
        End;

        cdsCidades.Next;
        cxProgress.Position := cxProgress.Position + 1;

        Application.ProcessMessages;
      End;
    End;

  Finally
    cdsCidades.EnableControls;
    cdsCidades.Close;
    edtVrMSeg.Text := '0,00';
    edtPerSeg.Text := '0,00';
    edtNomCid.Clear;
    pSetFocus(edtNomCid);

    FreeAndNil(qryUpdate);
  End;
end;

function TfrmManCadCidadeSigep.fGetEstados: String;
  Var
    intIndex : Integer;
begin
  Result := '';
  For intIndex := 0 To clbEstados.Items.Count -1 Do
  Begin
    If clbEstados.Checked[intIndex] Then
      Result := Result + clbEstados.Items[intIndex] + '_';
  End;
end;

function TfrmManCadCidadeSigep.fGetSQL: String;
  Var
    strEstados : String;
begin
  strEstados := fGetEstados;
  Result := '';
  Result := Result + ' SELECT CID_CODCID,            ';
  Result := Result + '        CID_NOMCID,            ';
  Result := Result + '        CID_ESTADO,            ';
  Result := Result + '        CID_VRMSEG,            ';
  Result := Result + '        CID_PERSEG,            ';
  Result := Result + '        "S" MARCA              ';
  Result := Result + ' FROM CADCID                   ';
  Result := Result + ' WHERE CID_NOMCID LIKE :NOMCID ';
  If not fEmptyStr(strEstados) Then
  Begin
    Result := Result + ' AND LOCATE(CID_ESTADO, "' + strEstados + '") > 0 ';
    Result := Result + ' AND IFNULL(CID_ESTADO,"") <> "" ';
  End;
  Result := Result + ' ORDER BY CID_NOMCID ';
end;

procedure TfrmManCadCidadeSigep.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  //inherited;
  If cdsCidades.Active And (cdsCidades.RecordCount > 0) Then
  Begin
    If fMensagem('', 'Deseja cancelar a atualização dos itens filtrados?', ['&Sim', '&Não'], 2) = 1 Then
      cdsCidades.Close;
    Action := caNone;
  End;

end;

procedure TfrmManCadCidadeSigep.FormCreate(Sender: TObject);
begin
  inherited;
  cdsCidades := TZClient.Create(Self);
  cxgCidadesTableView.DataController.DataSource := cdsCidades.dtsSource;
end;

procedure TfrmManCadCidadeSigep.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsCidades);
  inherited;
end;

procedure TfrmManCadCidadeSigep.pTodos(operacao: opcOperacao);
begin
  Try
    Foperacao := operacao;
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.lblGravando.Caption := 'Processando registros...';
    frmGravando.fExecutarAcao := fTodosProgresso;
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;
end;

function TfrmManCadCidadeSigep.fTodosProgresso(cxProgress: TcxProgressBar): Boolean;
begin
  Result := True;
  Try
    cdsCidades.DisableControls;
    cdsCidades.First;
    cxProgress.Properties.Max := cdsCidades.RecordCount;

    While not cdsCidades.Eof Do
    Begin
      cdsCidades.Edit;

      Case Foperacao Of
        opcMarcar    : cdsCidades.FieldByName('MARCA').AsString := 'S';
        opcDesmarcar : cdsCidades.FieldByName('MARCA').AsString := 'N';
        opcInverter  : cdsCidades.FieldByName('MARCA').AsString := IfThen(cdsCidades.FieldByName('MARCA').AsString = 'S', 'N', 'S');
      End;

      cdsCidades.Post;
      cdsCidades.Next;

      cxProgress.Position := cxProgress.Position + 1;
    End;
  Finally
    cdsCidades.First;
    cdsCidades.EnableControls;
  End;

end;

function TfrmManCadCidadeSigep.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If (Sender = edtVrMSeg) Then
    Begin
      Result := fStrToFloat(TEditFocus(Sender).Text) >= 0;
      If not Result Then
        fMensagem('', 'Informe um valor maior ou igual a zero!', ['&OK']);
    End

    Else
    If (Sender = edtPerSeg) Then
    Begin
      Result := (fStrToFloat(TEditFocus(Sender).Text) >= 0) And (fStrToFloat(TEditFocus(Sender).Text) <= 100);
      If not Result Then
        fMensagem('', 'Informe um valor entre zero (0) e cem (100)!', ['&OK']);
    End

  End;
end;

end.
