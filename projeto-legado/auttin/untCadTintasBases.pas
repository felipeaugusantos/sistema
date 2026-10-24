unit untCadTintasBases;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untCadTintas, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, Mask, DBCtrls, untICadastroTintaBase, DB, 
   Uni, DBEditFocus, untIConsulta, EditFocus,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadTintasBases = class(TfrmCadTintas) 
    lblCodigo: TLabel;
    lblBase: TLabel;
    lblDescricao: TLabel;
    lblItemBase: TLabel;
    lblCodUni: TLabel;
    lblPrecoCusto: TLabel;
    lblPrecoVenda: TLabel;
    lblMargem: TLabel;
    btnRestPreco: TSpeedButton;
    dbeBase: TDBEditFocus;
    dbeCodigo: TDBEditFocus;
    dbeDescricao: TDBEditFocus;
    dbeItemBase: TDBEditFocus;
    dbeCodUni: TDBEditFocus;
    dbePrecoCusto: TDBEditFocus;
    dbePrecoVenda: TDBEditFocus;
    dbeMargem: TDBEditFocus;
    edtDesItemBase: TEditFocus;
    edtDesUni: TEditFocus;
    edtSigUni: TEditFocus;
    lblEmbalagem: TLabel;
    dbeEmbala: TDBEditFocus;
    procedure btnRestPrecoClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    
    procedure dbeCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure dbeItemBaseExit(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbeItemBaseKeyPress(Sender: TObject; var Key: Char);
    procedure dbeEnterFocus(Sender: TObject);
    procedure dbePrecoVendaExit(Sender: TObject);
  private
    { Private declarations }
    cadastro: ICadastroTintaBase;
    consulta: IConsulta;
  protected
    procedure pCriarDataSets; override;
    procedure pLigarDataSets; overload; override;

    procedure pConfigurarLabels; override;
    procedure pConfigurarEdits; 
    procedure pCarregaUnidade; virtual;
    procedure pCarregaItem; override;
    procedure pSetaEnableReadOnly(DataSet: TDataSet); override;
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
    function fRetPrecoVenda(intOpcao: Integer): Double;
    function fGetItemJaRelacionado(): Boolean;
  public
    constructor Create(AOwner: TComponent; cadastro: ICadastroTintaBase); reintroduce;
    { Public declarations }
  end;

var
  frmCadTintasBases: TfrmCadTintasBases;

implementation

uses
  untFuncTinta, untFuncoesSimples,
  untPaiCad, Math, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadTintasBases }

constructor TfrmCadTintasBases.Create(AOwner: TComponent;
  cadastro: ICadastroTintaBase);
begin
  Self.cadastro := cadastro;
  Self.consulta := cadastro.fGetConsulta;
  inherited Create(AOwner, cadastro);

  pCriarDataSets;
  pLigarDataSets;
  pConfigurarLabels;
  pConfigurarEdits;
  pSetaCamposChaves;
  pSetaEnableReadOnly(qryCadastro);


  Caption := 'Cadastro de Bases - ' + cadastro.fGetNomeTinta;  
end;

procedure TfrmCadTintasBases.pCriarDataSets;
begin
  inherited pCriarDataSets;

  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoCusto)).DisplayFormat  := '0.00';
  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoCusto)).EditFormat     := '0.00';
  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoVenda)).DisplayFormat  := '0.00';
  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoVenda)).EditFormat     := '0.00';
  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoMargem)).DisplayFormat := '0.00';
  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoMargem)).EditFormat    := '0.00';
end;

procedure TfrmCadTintasBases.pLigarDataSets;
begin
  inherited pLigarDataSets;
  
  pLigarDataSets(dbeCodigo, lblCodigo, cadastro.fGetCampoCodigo);
  pLigarDataSets(dbeBase, lblBase, cadastro.fGetCampoBase);
  pLigarDataSets(dbeDescricao, lblDescricao, cadastro.fGetCampoDescricao);
  pLigarDataSets(dbeItemBase, lblItemBase, cadastro.fGetCampoCodItem);
  pLigarDataSets(dbeCodUni, lblCodUni, cadastro.fGetCampoUnidade);
  pLigarDataSets(dbePrecoCusto, lblPrecoCusto, cadastro.fGetCampoCusto);
  pLigarDataSets(dbePrecoVenda, lblPrecoVenda, cadastro.fGetCampoVenda);
  pLigarDataSets(dbeMargem, lblMargem, cadastro.fGetCampoMargem);
  pLigarDataSets(dbeEmbala, lblEmbalagem, cadastro.fGetCampoEmbala);

end;

procedure TfrmCadTintasBases.btnRestPrecoClick(Sender: TObject);
  Var
    fltPrecus: Double;
    fltMargem: Double;
    fltPreVen: Double;
begin
  inherited;
  pRetornaPrecos(dbeItemBase.Text, fltPrecus, fltMargem, fltPreVen);

  dbePrecoCusto.Field.AsFloat := fltPrecus;
  dbeMargem.Field.AsFloat     := fltMargem;
  dbePrecoVenda.Field.AsFloat := fltPreVen;
end;

procedure TfrmCadTintasBases.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  key := '/';
  If fPesqGenericaTinta(Self, cadastro.fGetNomeTabela(), qryTabela, Key, ArrSel, True, cadastro.fGetCampoCadIteCodIte, '', False) Then
  begin
    pSetFocus(btnAlterar);
    pCarregaItem;
    pCarregaUnidade;
  End;
end;

procedure TfrmCadTintasBases.pCarregaItem;
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
      qryGen.ParamByName('CODITE').AsString := dbeItemBase.Text;
      qryGen.Open;

      edtDesItemBase.Text := qryGen.FieldByName('ITE_DESITE').AsString;
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

procedure TfrmCadTintasBases.pCarregaUnidade;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text := 'SELECT UNI_CODUNI '+
                         '     , UNI_DESUNI '+
                         '     , UNI_SIGUNI '+
                         '  FROM CADUNI     '+
                         ' WHERE UNI_CODUNI = :CODUNI';
      qryGen.ParamByName('CODUNI').AsString := dbeCodUni.Text;
      qryGen.Open;

      dbeCodUni.Text := qryGen.FieldByName('UNI_CODUNI').AsString;
      edtDesUni.Text := qryGen.FieldByName('UNI_DESUNI').AsString;
      edtSigUni.Text := qryGen.FieldByName('UNI_SIGUNI').AsString;
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

procedure TfrmCadTintasBases.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pCarregaItem;
  pCarregaUnidade;
  
  If dbeCodigo.CanFocus Then
    pSetFocus(dbeCodigo)
  Else If dbeBase.CanFocus Then
    pSetFocus(dbeBase);
    
  pSetaEnableReadOnly(qryCadastro);
end;

procedure TfrmCadTintasBases.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pCarregaItem;
  pCarregaUnidade;
  pSetaEnableReadOnly(qryCadastro);
end;

procedure TfrmCadTintasBases.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaItem;
  pCarregaUnidade;
  pSetaEnableReadOnly(qryCadastro);
end;

procedure TfrmCadTintasBases.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pSetaEnableReadOnly(qryCadastro);
  pDesabilitaCamposChaves;

  If dbeCodigo.CanFocus Then
    pSetFocus(dbeCodigo)
  Else If dbeBase.CanFocus Then
    pSetFocus(dbeBase)
  Else If dbeDescricao.CanFocus Then
    pSetFocus(dbeDescricao)
  Else If dbeItemBase.CanFocus Then
    pSetFocus(dbeItemBase)
  Else If dbeCodUni.CanFocus Then
    pSetFocus(dbeCodUni);
end;

procedure TfrmCadTintasBases.dbeEnterFocus(Sender: TObject);
begin
  if (Sender is TDBEditFocus) then
  begin
    if (Sender as TDBEditFocus).TabStop then
      (Sender as TDBEditFocus).FocusColor := clInfoBk
    else
      (Sender as TDBEditFocus).FocusColor := clWindow;
  end;
end;

procedure TfrmCadTintasBases.dbeCodUniKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
    if fPesqUnidade(Self, dbeCodUni, nil, nil, nil, Key, arrSel) then
      if fValidaCampos(dbeCodUni, True) then
        SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadTintasBases.pConfigurarLabels;
begin
  lblCodigo.Caption     := cadastro.fGetLabelCodigo    + ':';
  lblBase.Caption       := cadastro.fGetLabelBase      + ':';
  lblDescricao.Caption  := cadastro.fGetLabelDescricao + ':';
  lblItemBase.Caption   := cadastro.fGetLabelCodItem   + ':';
  lblCodUni.Caption     := cadastro.fGetLabelUndiade   + ':';
  lblPrecoCusto.Caption := cadastro.fGetLabelCusto     + ':';
  lblPrecoVenda.Caption := cadastro.fGetLabelVenda     + ':';
  lblMargem.Caption     := cadastro.fGetLabelMargem    + ':';
end;

procedure TfrmCadTintasBases.pConfigurarEdits;
begin
  If dbeBase.Visible Then
    dbeBase.Width := fGetLarguraEdit(cadastro.fGetCampoBase);

  If dbeCodigo.Visible Then
    dbeCodigo.Width := fGetLarguraEdit(cadastro.fGetCampoCodigo);

  If Not dbeCodigo.Visible Then
  Begin
    dbeBase.Left := dbeCodigo.Left;
    lblBase.Left := dbeBase.Left - Canvas.TextWidth(lblBase.Caption + ':');
  End;
end;

procedure TfrmCadTintasBases.dbeItemBaseExit(Sender: TObject);
begin
  inherited;
  If Not dbeItemBase.ReadOnly Then
  Begin
    pCarregaItem;
    pCarregaUnidade;
  End;

end;

procedure TfrmCadTintasBases.btnGravarClick(Sender: TObject);
begin
  inherited;
  pSetaEnableReadOnly(qryCadastro);
end;

procedure TfrmCadTintasBases.pSetaEnableReadOnly(DataSet: TDataSet);
begin
  Inherited pSetaEnableReadOnly(DataSet);
  Try
    btnRestPreco.Visible    := qryCadastro.State = dsEdit;
    edtDesItemBase.ReadOnly := True;
    edtDesUni.ReadOnly      := True;
    edtSigUni.ReadOnly      := True;
    dbeEmbala.ReadOnly      := True;
  Except
  End;
end;

procedure TfrmCadTintasBases.FormShow(Sender: TObject);
begin
  inherited;
  pSetaEnableReadOnly(qryCadastro);
end;

procedure TfrmCadTintasBases.dbeItemBaseKeyPress(Sender: TObject;
  var Key: Char);
begin
  If (Not dbeItemBase.ReadOnly) And (fEntraCons(Key)) Then
  Begin
    pConsultaItemKeyPress(Sender, Key, cadastro.fGetFiltro);
    pCarregaItem;
    pCarregaUnidade;
    btnRestPreco.Click;
  End;
end;


procedure TfrmCadTintasBases.dbePrecoVendaExit(Sender: TObject);
begin
  inherited;
  pSetFocus(btnGravar);
end;

function TfrmCadTintasBases.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  If (fEmptyStr(dbeItemBase.Text) And (fInComponents(Sender, [dbePrecoCusto, dbePrecoVenda, dbeMargem]))) Then
  Begin
    Result := True;
    Exit;
  End;

  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If (Result) Then
  Begin
    If Sender = dbeCodUni Then
    Begin
      pCarregaUnidade;
      if fEmptyStr(edtDesUni.Text) then
      begin
        fMensagem('ATENÇÃO!', 'A unidade selecionada não é válida!', ['OK']);
        Result := False;
      end;
    End
    Else If Sender = dbePrecoCusto Then
    Begin
      dbePrecoVenda.Field.AsFloat := fRetPrecoVenda(1);
    End
    Else If Sender = dbePrecoVenda Then
    Begin
      dbeMargem.Field.AsFloat := fRetPrecoVenda(2);
    End
    Else If Sender = dbeMargem Then
    Begin
      dbePrecoVenda.Field.AsFloat := fRetPrecoVenda(1);
    End
    Else If Sender = dbeItemBase Then
    Begin
      dbeItemBaseExit(Sender);
      If fGetItemJaRelacionado Then
      Begin
        Result := fMensagem('ATENÇÃO', Format('O produto %s já está relacionado com outra base'#13#10'Deseja Continuar?' , [dbeItemBase.Text]), ['Sim', 'Não']) = 1;
      End
      else if (not fEmptyStr(dbeItemBase.Text)) and (fEmptyStr(edtDesItemBase.Text)) then
      begin
        fMensagem('ATENÇÃO', 'O produto não está cadastrado!', ['OK']);
        Result := False;
      end;
    End;

  End;


  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmCadTintasBases.fRetPrecoVenda(intOpcao: Integer): Double;
begin
  If fEmptyStr(dbePrecoVenda.Text) Then
    dbePrecoVenda.Text := '0,00';

  If fEmptyStr(dbeMargem.Text) Then
    dbeMargem.Text := '0,00';

  Result := fCalculaPrecoVenda(intOpcao,
                               fStrToFloat(dbePrecoCusto.Text),
                               fStrToFloat(dbePrecoVenda.Text),
                               fStrToFloat(dbeMargem.Text),
                               0.0,
                               0.0,
                               0.0,
                               0.0);
end;

function TfrmCadTintasBases.fGetItemJaRelacionado: Boolean;
  Var
    qryGen: TUniQuery;
begin
  Result := False;
  If Not fEmptyStr(dbeItemBase.Text) Then
  Begin
    qryGen := fCriaQuery(Self);
    qryGen.SQL.Text := 'SELECT COUNT(*)    QTD FROM ' +
                  cadastro.fGetNomeTabela +
                  ' WHERE ' +
                  cadastro.fGetCampoCodItem + ' = "' +
                  dbeItemBase.Text + '"' +
                  ' AND AUTOINCREM <> ' +
                  AnsiQuotedStr(qryCadastro.FieldByName('AUTOINCREM').AsString, '"');
    qryGen.Open;
    Result := qryGen.FieldByName('QTD').AsInteger > 0;
    FreeAndNil(qryGen);
  End;
end;

end.

