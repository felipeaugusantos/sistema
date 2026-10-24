{***********************}
{* qryConSer -> CADSER *}
{********************JB*}

unit untCadContratos;

interface

uses
  Windows, Classes, Controls, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids,
  DBGridCitel, DBGrids, EditFocus, Uni, DB, AppEvnts, UniClientDataSet, UniDataSetProvider,
  BitBtnLockedIncrem;

Type

  TCadContratos = class(TComponent)
    private
      FTblTmp: TUniQuery;
      FdspTmp: TUniDataSetProvider;
      FCdsTmp: TUniClientDataSet;
      FSrcTmp: TDataSource;
      FCadCon: TUniQuery;
      FDtsCon: TDataSource;

      procedure pAdicionaServico(strCodCon,
                                 strCodCli,
                                 strDesCon,
                                 strCodSer,
                                 strDesSer: String;
                                 fltValSer: Double);
      procedure pDeletaTemporaria;
    protected

    public

      Constructor Create(AOwner: TComponent); reintroduce;
      Destructor Destroy; override;

      procedure pAddServTmp(strCodSer,
                            strDesSer: String;
                            fltValSer: Double;
                            intAutInc: Integer);

      procedure pCriaContrato(strCodCon,
                              strCodCli,
                              strDesCon: String);

      procedure pCarregaContratoTmp(strCodCon, strCodCli: String);

      function fCalculaTotalTmp: Double;

      property cdsCdsTmp: TUniClientDataSet Read FCdsTmp;
      property qryCadCon: TUniQuery Read FCadCon;
      property dtsTblTmp: TDataSource Read FSrcTmp;
  End;

type
  TfrmCadContratos = class(TfrmPai)
    pnlCabecalho: TPanel;
    dbgServicos: TDBGridCitel;
    pnlTotais: TPanel;
    pnlServicos: TPanel;
    Label1: TLabel;
    edtCodCon: TEditFocus;
    Label2: TLabel;
    edtDesCon: TEditFocus;
    Label3: TLabel;
    edtDesSer: TEditFocus;
    edtCodSer: TEditFocus;
    Label4: TLabel;
    edtValSer: TEditFocus;
    Label32: TLabel;
    edtTotCon: TEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    btnAdicionar: TBitBtnLocked;
    btnCancelar: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure edtCodConKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure dbgServicosDblClick(Sender: TObject);
    procedure dbgServicosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodSerKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    qryConSer: TUniQuery;

    conContrato: TCadContratos;
    procedure pAtualizaCabecalho;
    procedure pHabilitaPanels(blnCabecalho, blnOutros: Boolean);
    procedure pAtualizaDados(Dataset: TDataSet);

  protected
    procedure pEscapePressed; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strCodCli: String;
  end;

var
  frmCadContratos: TfrmCadContratos;

implementation

uses SysUtils, Forms, untFuncoes, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadContratos }

procedure TfrmCadContratos.FormCreate(Sender: TObject);
  var
    strSQL: String;
begin
  inherited;
  qryTabela   := fCriaQuery(Self);
  conContrato := TCadContratos.Create(Self);
  conContrato.cdsCdsTmp.AfterScroll := pAtualizaDados;

  strSQL      := 'SELECT * FROM CADSER';
  qryConSer   := fCriarQuery(strSQL, Self);

  dbgServicos.DataSource := conContrato.dtsTblTmp;
end;

function TfrmCadContratos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtCodCon) And (blnBuscaPorChave) Then
  Begin

    If (fEmptyStr(edtCodCon.Text)) Then
    Begin
      conContrato.pDeletaTemporaria;
      conContrato.pCarregaContratoTmp(edtCodCon.Text, strCodCli);
      edtDesCon.Clear;
    End
    Else
    Begin
      conContrato.pCarregaContratoTmp(edtCodCon.Text, strCodCli);
      If (conContrato.cdsCdsTmp.IsEmpty) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse contrato não está cadastrado!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        edtTotCon.Text := FloatToStrF(conContrato.fCalculaTotalTmp, ffFixed, 12, 2);
        pAtualizaCabecalho;
        btnCancelar.Click;
      End;
    End;

  End

  Else If (Sender = edtDesCon) Then
  Begin
    If (fEmptyStr(edtDesCon.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O nome do contrato deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pHabilitaPanels(False, True);
    End;
  End

  Else If (Sender = edtCodSer) And (blnBuscaPorChave) Then
  Begin

    If (fEmptyStr(edtCodSer.Text)) Then
    Begin
      btnCancelar.Click;
      If (blnBuscaPorChave) Then
      Begin
        pSetFocus(btnCancelar);
        pAtualizaDados(Nil);
      End;
    End
    Else
    Begin
      edtDesSer.Text := fRetDesServico(edtCodSer.Text);
      if fEmptyStr(edtDesSer.Text) then
      Begin
        fMensagem('ATENÇÃO!', 'Esse serviço não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;

  End

  Else If (Sender = edtDesSer) And (blnBuscaPorChave) Then
  Begin

    If (fEmptyStr(edtDesSer.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A descrição do serviço deve ser preenchida!', ['&Ok']);
      Result := False;
    End;

  End

  Else If (Sender = edtValSer) And (blnBuscaPorChave) Then
  Begin
    If (fEmptyStr(edtValSer.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor do serviço deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (fStrToFloat(edtValSer.Text) < 0.0) Then
    Begin
      fMensagem('ATENÇÃO!', 'O valor do serviço deve ser maior ou igual a Zero!', ['&Ok']);
      Result := False;
    End;
  End;

end;

procedure TfrmCadContratos.pAtualizaCabecalho;
begin
  edtDesCon.Text := conContrato.cdsCdsTmp.FieldByName('CON_DESCON').AsString;
end;

procedure TfrmCadContratos.pHabilitaPanels(blnCabecalho,
  blnOutros: Boolean);
begin
  pnlCabecalho.Enabled := blnCabecalho;
  pnlServicos.Enabled  := blnOutros;
  dbgServicos.Enabled  := blnOutros;
end;

procedure TfrmCadContratos.pEscapePressed;
begin
  If (ActiveControl = dbgServicos) Then
  Begin
    btnCancelar.Click;
    pSetFocus(edtCodSer);
  End
  Else If (ActiveControl.Parent = pnlServicos) Then
  Begin
    pHabilitaPanels(True, False);
    pSetFocus(edtDesCon);
  End
  Else If (ActiveControl.Parent = pnlCabecalho) Then
  Begin
    inherited;
  End;
end;

procedure TfrmCadContratos.pAtualizaDados(Dataset: TDataSet);
begin

  If (Not conContrato.cdsCdsTmp.Active) Or
     (conContrato.cdsCdsTmp.IsEmpty)    Then
  Begin
    Exit;
  End;

  edtCodSer.Text := conContrato.cdsCdsTmp.FieldByName('CON_CODSER').AsString;
  edtDesSer.Text := conContrato.cdsCdsTmp.FieldByName('CON_DESSER').AsString;
  edtValSer.Text := FloatToStrF(conContrato.cdsCdsTmp.FieldByName('CON_VALSER').AsFloat, ffFixed, 12, 2);

end;

{ TCadContratos }

constructor TCadContratos.Create(AOwner: TComponent);
begin

  inherited Create(AOwner);

  FTblTmp := fCriaQuery(Self);
  FCadCon := fCriaQuery(Self);
  FDtsCon := fCriaDataSource(FCadCon);

  FdspTmp := TUniDataSetProvider.Create(Self);
  FdspTmp.DataSet := FTblTmp;
  FCdsTmp := TUniClientDataSet.Create(Self);
  FCdsTmp.SetProvider(FdspTmp);
  FSrcTmp := fCriaDataSource(FCdsTmp);

  FCdsTmp.AggregatesActive := True;
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_VALSER';
    FieldName     := 'TOT_VALSER';
    DataSet       := FCdsTmp;
    Expression    := 'SUM(CON_VALSER)';
    DisplayFormat := '#,##0.00';
    Active        := True;
  End;

  With FCadCon Do
  Begin
    SQL.Add('SELECT * FROM CADCON WHERE FALSE');
    Active := True;
  End;

end;

procedure TCadContratos.pAdicionaServico(strCodCon, strCodCli, strDesCon,
  strCodSer, strDesSer: String; fltValSer: Double);
begin

  If (Not FCadCon.Active) Then
    FCadCon.Active := True;

  FCadCon.Append;
  FCadCon.FieldByName('CON_CODCON').AsString := strCodCon;
  FCadCon.FieldByName('CON_CODCLI').AsString := strCodCli;
  FCadCon.FieldByName('CON_DESCON').AsString := strDesCon;
  FCadCon.FieldByName('CON_CODSER').AsString := strCodSer;
  FCadCon.FieldByName('CON_DESSER').AsString := strDesSer;
  FCadCon.FieldByName('CON_VALSER').AsFloat  := fltValSer;
  FCadCon.FieldByName('CON_CODEMP').AsString := VS_strCodEmp;
  FCadCon.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADCON', VS_strCodEmp);
  FCadCon.Post;

end;

procedure TCadContratos.pCriaContrato(strCodCon, strCodCli, strDesCon: String);
  Var
    intContador: Integer;
    qryAux: TUniQuery;

    function fRetSeqCon: String;
      Var
        strSQL: String;
    begin

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  CLI_SEQCON ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADCLI ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CLI_CODCLI = :CODCLI ';

      With qryAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODCLI').AsString := strCodCli;
        Open;
        Result := fStrZero(Fields[0].AsInteger, 3);
        Close;
      End;

      strSQL := '';
      strSQL := strSQL + 'UPDATE CADCLI SET ';
      strSQL := strSQL + '  CLI_SEQCON = IFNULL(CLI_SEQCON, 0) + 1 ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CLI_CODCLI = :CODCLI ';

      With qryAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODCLI').AsString := strCodCli;
        ExecSQL;
        Close;
      End;

    end;
begin

  intContador := 0;

  qryAux := fCriaQuery(Self);

  If (fEmptyStr(strCodCon)) Then
  Begin
    strCodCon := fRetSeqCon;
  End
  Else
  Begin
    qryAux.SQL.Add('DELETE FROM CADCON WHERE CON_CODCON = :CODCON AND CON_CODCLI = :CODCLI');
    qryAux.ParamByName('CODCON').AsString := strCodCon;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.ExecSQL;
    qryAux.Close;
  End;

  FCdsTmp.First;

  While (Not FCdsTmp.Eof) And (intContador < fCfgSis('LINSER', varInteger)) Do
  Begin
    pAdicionaServico(strCodCon,
                     strCodCli,
                     strDesCon,
                     FCdsTmp.FieldByName('CON_CODSER').AsString,
                     FCdsTmp.FieldByName('CON_DESSER').AsString,
                     FCdsTmp.FieldByName('CON_VALSER').AsFloat);

    FCdsTmp.Next;
    Inc(intContador);
  End;

  FreeAndNil(qryAux);
end;

procedure TCadContratos.pDeletaTemporaria;
begin
  If FCdsTmp.Active Then
    FCdsTmp.EmptyDataSet;
end;

procedure TCadContratos.pAddServTmp(strCodSer, strDesSer: String;
  fltValSer: Double; intAutInc: Integer);
  Var
    pAfterTmp: TDataSetNotifyEvent;
begin

  With FCdsTmp Do
  Begin
    pAfterTmp := FCdsTmp.AfterScroll;
    FCdsTmp.AfterScroll := Nil;

    If (Locate('AUTOINCREM', intAutInc, [])) Then
      Edit
    Else
      Append;

    FieldByName('CON_CODSER').AsString := strCodSer;
    FieldByName('CON_DESSER').AsString := strDesSer;
    FieldByName('CON_VALSER').AsFloat  := fltValSer;
    Post;

    FCdsTmp.AfterScroll := pAfterTmp;

  End;

end;

procedure TfrmCadContratos.edtCodConKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrContrato : TConsultasArray;
begin
  inherited;

  If fPesqContratos(Self, edtCodCon, edtDesCon, Nil, Key, arrContrato, True, strCodCli) Then
  Begin
    If (fValidaCampos(edtCodCon, True)) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadContratos.edtCodSerKeyPress(Sender: TObject; var Key: Char);
  Var
    arrServ: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE SERVIÇOS   *}
  {****************************RV*}
  If fPesqServicos(Self, edtCodSer, edtDesSer, Nil, Key, arrServ) Then
  Begin
    If fValidaCampos(edtCodSer, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

destructor TCadContratos.Destroy;
begin
  FTblTmp.Close;
  qryCadCon.Close;
  cdsCdsTmp.AfterScroll := Nil;
  inherited;
end;

procedure TCadContratos.pCarregaContratoTmp(strCodCon, strCodCli: String);
  Var
    strSQL: String;
begin

  pDeletaTemporaria;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CON_CODSER, ';
  strSQL := strSQL + '  CON_DESSER, ';
  strSQL := strSQL + '  CON_VALSER, ';
  strSQL := strSQL + '  CON_DESCON, ';
  strSQL := strSQL + '  AUTOINCREM  ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCON ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CON_CODCON = :CODCON AND ';
  strSQL := strSQL + '  CON_CODCLI = :CODCLI ';


  With FTblTmp Do
  Begin
    Close;
    FCdsTmp.Close;

    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCON').AsString := strCodCon;
    ParamByName('CODCLI').AsString := strCodCli;

    Open;
    pSetaClient(FTblTmp);

    FCdsTmp.SetProvider(FdspTmp);
    FCdsTmp.Open;
    pSetaClient(FCdsTmp);
  End;

end;

procedure TfrmCadContratos.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  If (Not fValidaPanel(pnlServicos)) Then
    Exit;

  If (conContrato.cdsCdsTmp.RecordCount >= fCfgSis('LINSER', varInteger)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Só é permitido a inserção de ' + IntToStr(fCfgSis('LINSER', varInteger)) + ' serviço(s)!', ['&Ok']);
    Exit;
  End;

  conContrato.pAddServTmp(edtCodSer.Text,
                          edtDesSer.Text,
                          fStrToFloat(edtValSer.Text),
                          btnAdicionar.Tag);

  edtTotCon.Text := FloatToStrF(conContrato.fCalculaTotalTmp, ffFixed, 12, 2);
  btnCancelar.Click;
end;

procedure TfrmCadContratos.btnCancelarClick(Sender: TObject);
begin
  inherited;
  edtCodSer.Enabled := True;
  edtCodSer.Clear;
  edtDesSer.Clear;
  edtValSer.Text := '0,00';
  If (edtCodSer.Enabled) And (edtCodSer.Parent.Enabled) Then
    pSetFocus(edtCodSer);

  btnAdicionar.Tag := 0;
end;

procedure TfrmCadContratos.dbgServicosDblClick(Sender: TObject);
begin
  inherited;
  edtCodSer.Enabled := False;
  pSetFocus(edtDesSer);
  btnAdicionar.Tag := conContrato.cdsCdsTmp.FieldByName('AUTOINCREM').AsInteger;
end;

procedure TfrmCadContratos.dbgServicosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    dbgServicosDblClick(dbgServicos);
  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    pSetFocus(edtCodSer);
  End
  Else If (Key = VK_DELETE) Then
  Begin
    If (Not conContrato.cdsCdsTmp.IsEmpty) Then
      conContrato.cdsCdsTmp.Delete;
    edtTotCon.Text := FloatToStrF(conContrato.fCalculaTotalTmp, ffFixed, 12, 2);

    If (conContrato.cdsCdsTmp.IsEmpty) Then
    Begin
      btnCancelar.Click;
    End;
  End;
end;

procedure TfrmCadContratos.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    Try
      fStartTransaction;
      conContrato.pCriaContrato(edtCodCon.Text, strCodCli, edtDesCon.Text);
      btnSair.Click;
      fCommit;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[TfrmCadContratos.btnConfirmaDadosClick]');
      End;
    End;
  End;
end;

procedure TfrmCadContratos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F10) Then
  Begin
    Key := 0;
    btnConfirmaDados.Click;
  End;
end;

function TCadContratos.fCalculaTotalTmp: Double;
begin
  Result := fDoubleAggregate(FCdsTmp, 'TOT_VALSER');
end;

end.

