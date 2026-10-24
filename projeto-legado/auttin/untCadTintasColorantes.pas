unit untCadTintasColorantes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untCadTintas, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, untICadastroTintaColorantes, untIConsulta, Mask, DBCtrls,
  DBEditFocus, EditFocus, DB,  
  Uni, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadTintasColorantes = class(TfrmCadTintas)
    dbeCodigo: TDBEditFocus;
    lblCodigo: TLabel;
    lblItem: TLabel;
    dbeItem: TDBEditFocus;
    edtDescricaoItem: TEditFocus;
    btnRestPreco: TSpeedButton;
    lblCusto: TLabel;
    dbeCusto: TDBEditFocus;
    lblMargem: TLabel;
    dbeMargem: TDBEditFocus;
    lblVenda: TLabel;
    dbeVenda: TDBEditFocus;
    dbeDescricao: TDBEditFocus;
    lblDescricao: TLabel;
    procedure btnRestPrecoClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure dbeItemExit(Sender: TObject);
    procedure dbeItemKeyPress(Sender: TObject; var Key: Char);
    procedure dbeEnterFocus(Sender: TObject);
  private
    { Private declarations }
    cadastro: ICadastroTintaColorantes;
    consulta: IConsulta;
    strCodIteAnt : String;

  protected
    procedure pCriarDataSets; override;
    procedure pLigarDataSets; override;
    procedure pConfigurarLabels; override;
    procedure pSetaEnableReadOnly(DataSet: TDataSet); override;
    procedure pCarregaItem; override;
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
    function fRetPrecoVenda(intOpcao: Integer): Double;
    function fGetItemJaRelacionado(): Boolean;
  public
    constructor Create(AOwner: TComponent; cadastro: ICadastroTintaColorantes); reintroduce;
    { Public declarations }
  end;

var
  frmCadTintasColorantes: TfrmCadTintasColorantes;

implementation

uses untFuncTinta,
     untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadTintasColorantes }

constructor TfrmCadTintasColorantes.Create(AOwner: TComponent;
  cadastro: ICadastroTintaColorantes);
begin
  Self.cadastro := cadastro;
  consulta := cadastro.fGetConsulta;
  Inherited Create(AOwner, cadastro);

  pCriarDataSets;
  pLigarDataSets;
  pConfigurarLabels;
  pSetaCamposChaves;
  pSetaEnableReadOnly(qryCadastro);

  Caption := 'Cadastro de Colorantes - ' + cadastro.fGetNomeTinta;
end;

procedure TfrmCadTintasColorantes.pConfigurarLabels;
begin
  lblCodigo.Caption := cadastro.fGetLabelCodigo + ':';
  lblItem.Caption := cadastro.fGetLabelItem + ':';
  lblCusto.Caption := cadastro.fGetLabelCusto + ':';
  lblMargem.Caption := cadastro.fGetLabelMargem + ':';
  lblVenda.Caption := cadastro.fGetLabelVenda + ':';
end;

procedure TfrmCadTintasColorantes.pCriarDataSets;
begin
  inherited pCriarDataSets;

  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoCusto)).DisplayFormat := '0.00';
  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoCusto)).EditFormat := '0.00';
  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoVenda)).DisplayFormat := '0.00';
  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoVenda)).EditFormat := '0.00';
  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoMargem)).DisplayFormat := '0.00';
  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoMargem)).EditFormat := '0.00';
end;

procedure TfrmCadTintasColorantes.pLigarDataSets;
begin
  inherited pLigarDataSets;
  
  pLigarDataSets(dbeCodigo, lblCodigo, cadastro.fGetCampoCodigo);
  pLigarDataSets(dbeDescricao, lblDescricao , cadastro.fGetCampoDescricao);
  pLigarDataSets(dbeItem, lblItem, cadastro.fGetCampoItem);
  pLigarDataSets(dbeCusto, lblCusto, cadastro.fGetCampoCusto);
  pLigarDataSets(dbeMargem, lblMargem, cadastro.fGetCampoMargem);
  pLigarDataSets(dbeVenda, lblVenda, cadastro.fGetCampoVenda);
end;

procedure TfrmCadTintasColorantes.pSetaEnableReadOnly(DataSet: TDataSet);
var
  intCont: Integer;
begin
  Inherited pSetaEnableReadOnly(DataSet);
  btnRestPreco.Visible := qryCadastro.State = dsEdit;
  edtDescricaoItem.ReadOnly := True;

  If qryCadastro.State = dsBrowse Then
  Begin
    For intCont := 0 To ComponentCount - 1 Do
    Begin
      If Components[intCont] Is TDBEdit Then
      Begin
        TDBEdit(Components[intCont]).Enabled  := False;
        TDBEdit(Components[intCont]).ReadOnly := True;
      End;
    End;
  End;
end;

procedure TfrmCadTintasColorantes.btnRestPrecoClick(Sender: TObject);
  Var
    fltPrecus: Double;
    fltMargem: Double;
    fltPreVen: Double;
begin
  inherited;
  pRetornaPrecos(dbeItem.Text, fltPrecus, fltMargem, fltPreVen);
  dbeCusto.Field.AsFloat := fltPrecus;
  dbeMargem.Field.AsFloat := fltMargem;
  dbeVenda.Field.AsFloat := fltPreVen;
end;

procedure TfrmCadTintasColorantes.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  If fPesqGenericaTinta(Self, cadastro.fGetNomeTabela, qryTabela, Key, arrSel, True, cadastro.fGetCampoCadIteCodIte, '', False) Then
    pSetFocus(btnAlterar);
  pCarregaItem;
end;

procedure TfrmCadTintasColorantes.pCarregaItem;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT                             ' +
        '   I.ITE_DESITE                     ' +
        ' FROM                               ' +
        '   CADITE I                         ' +
        '   INNER JOIN ITEGER G              ' +
        '     ON I.ITE_CODITE = G.ITE_CODITE ' +
        '   INNER JOIN CADMAR M              ' +
        '     ON I.ITE_CODMAR = M.MAR_CODMAR ' +
        ' WHERE G.ITE_IMPLIS = "S"           ' +
        '   AND G.ITE_CODEMP = :CODEMP       ' +
        '   AND I.ITE_CODITE = :CODITE       ';
      qryGen.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryGen.ParamByName('CODITE').AsString := dbeItem.Text;
      qryGen.Open;

      edtDescricaoItem.Text := qryGen.FieldByName('ITE_DESITE').AsString;
    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

procedure TfrmCadTintasColorantes.btnIncluirClick(Sender: TObject);
begin
  strCodIteAnt := '';
  inherited;
  pSetaEnableReadOnly(qryCadastro);
  pCarregaItem;
  pSetFocus(dbeCodigo);
end;

procedure TfrmCadTintasColorantes.btnExcluirClick(Sender: TObject);
begin
  strCodIteAnt := dbeItem.Text;
  inherited;

  if fEmptyStr(dbeItem.Text) Then
    pEnviarLogRep(strCodIteAnt, cadastro.fGetIdePro);

  pCarregaItem;
  pSetaEnableReadOnly(qryCadastro);
end;

procedure TfrmCadTintasColorantes.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaItem;
  pSetaEnableReadOnly(qryCadastro);
end;

procedure TfrmCadTintasColorantes.btnAlterarClick(Sender: TObject);
begin
  strCodIteAnt := dbeItem.Text;
  inherited;
  pSetaEnableReadOnly(qryCadastro);
  pDesabilitaCamposChaves;

  If dbeCodigo.CanFocus Then
    pSetFocus(dbeCodigo)
  Else If dbeDescricao.CanFocus Then
    pSetFocus(dbeDescricao)
  Else If dbeItem.CanFocus Then
    pSetFocus(dbeItem);
end;

procedure TfrmCadTintasColorantes.FormShow(Sender: TObject);
begin
  inherited;
  pSetaEnableReadOnly(qryCadastro);
end;

procedure TfrmCadTintasColorantes.btnGravarClick(Sender: TObject);
begin
  blnUsaProCodigo := False;
  Try
    fStartTransaction;
    inherited;

    If Not (fEmptyStr(strCoditeAnt)) Then
    Begin
      If (strCoditeAnt <> dbeItem.Text) Then
        pEnviarLogRep(strCodIteAnt, cadastro.fGetIdePro);
    End;

    pSetaEnableReadOnly(qryCadastro);
    If blnGravou Then
    Begin
      cadastro.pAtualizaFatorTintometrico;
      fCommit;
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[btnGravarClick]');
    End;
  End;
end;

procedure TfrmCadTintasColorantes.dbeEnterFocus(Sender: TObject);
begin
  if (Sender is TDBEditFocus) then
  begin
    if (Sender as TDBEditFocus).TabStop then
      (Sender as TDBEditFocus).FocusColor := clInfoBk
    else
      (Sender as TDBEditFocus).FocusColor := clWindow;
  end;
end;

procedure TfrmCadTintasColorantes.dbeItemExit(Sender: TObject);
begin
  inherited;
  pCarregaItem;
  pSetaEnableReadOnly(qryCadastro);
end;

procedure TfrmCadTintasColorantes.dbeItemKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    pConsultaItemKeyPress(Sender, Key);
    pCarregaItem;
    btnRestPreco.Click;
  End;
end;

function TfrmCadTintasColorantes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  If (fEmptyStr(dbeItem.Text) And (fInComponents(Sender, [dbeCusto, dbeVenda, dbeMargem]))) Then
  Begin
    Result := True;
    Exit;
  End;

  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If (Result) Then
  Begin
    If Sender = dbeCusto Then
    Begin
      dbeVenda.Field.AsFloat := fRetPrecoVenda(1);
    End
    Else If Sender = dbeVenda Then
    Begin
      dbeMargem.Field.AsFloat := fRetPrecoVenda(2);
    End
    Else If Sender = dbeMargem Then
    Begin
      dbeVenda.Field.AsFloat := fRetPrecoVenda(1);
    End
    Else If Sender = dbeItem Then
    begin
      If fEmptyStr(dbeItem.Text) Then
      Begin
        dbeItem.Field.Value := Null;
      End
      Else
      Begin
        dbeItemExit(Sender);
        If fGetItemJaRelacionado Then
        Begin
          Result := fMensagem('ATENÇÃO', Format('O produto %s já está relacionado com outro colorante'#13#10'Deseja Continuar?' , [dbeItem.Text]), ['Sim', 'Não']) = 1;
        End
        else if (not fEmptyStr(dbeItem.Text)) and (fEmptyStr(edtDescricaoItem.Text)) then
        begin
          fMensagem('ATENÇÃO', 'O produto não está cadastrado!', ['OK']);
          Result := False;
        end;
      End;
    End;

  End;
end;

function TfrmCadTintasColorantes.fRetPrecoVenda(intOpcao: Integer): Double;
begin
  If fEmptyStr(dbeVenda.Text) Then
    dbeVenda.Text := '0,00';

  If fEmptyStr(dbeMargem.Text) Then
    dbeMargem.Text := '0,00';

  Result := fCalculaPrecoVenda(intOpcao,
                               fStrToFloat(dbeCusto.Text),
                               fStrToFloat(dbeVenda.Text),
                               fStrToFloat(dbeMargem.Text),
                               0.0,
                               0.0,
                               0.0,
                               0.0);
end;

function TfrmCadTintasColorantes.fGetItemJaRelacionado: Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT COUNT(*)    QTD FROM ' +
                cadastro.fGetNomeTabela +
                ' WHERE ' +
                cadastro.fGetCampoItem + ' = "' +
                dbeItem.Text + '"' +
                ' AND AUTOINCREM <> ' +
                AnsiQuotedStr(qryCadastro.FieldByName('AUTOINCREM').AsString, '"');
  qryGen.Open;
  Result := qryGen.FieldByName('QTD').AsInteger > 0;
  FreeAndNil(qryGen);
end;

end.

