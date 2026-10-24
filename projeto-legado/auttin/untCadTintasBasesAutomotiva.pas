unit untCadTintasBasesAutomotiva;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untCadTintas, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, untICadastroTintaBaseAutomotiva, untIConsulta, DB, Mask,
  DBCtrls, DBEditFocus,
  Uni, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadTintasBasesAutomotiva = class(TfrmCadTintas)
    lblCodigo: TLabel;
    lblDescricao: TLabel;
    lblEmbalagem: TLabel;
    lblPesoEspecifico: TLabel;
    lblCodigoItem: TLabel;
    lblPrecoCusto: TLabel;
    lblMargem: TLabel;
    lblPrecoVenda: TLabel;
    edtDescricaoItem: TEdit;
    btnRestPreco: TSpeedButton;
    dbeCodigo: TDBEditFocus;
    dbeDescricao: TDBEditFocus;
    dbeEmbalagem: TDBEditFocus;
    dbePesoEspecifico: TDBEditFocus;
    dbeCodigoItem: TDBEditFocus;
    dbePrecoCusto: TDBEditFocus;
    dbeMargem: TDBEditFocus;
    dbePrecoVenda: TDBEditFocus;
    procedure btnRestPrecoClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeCodigoItemExit(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbeCodigoItemKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    StrCodIteAnt : String;
    cadastro     : ICadastroTintaBaseAutomotiva;
    consulta     : IConsulta;
    procedure pAcertaCnvMl;
  protected
    procedure pCriarDataSets; override;
    procedure pLigarDataSets; override;
    procedure pCarregaItem; override;
    procedure pConfigurarLabels; override;
    procedure pSetaEnableReadOnly(DataSet: TDataSet); override;
    function fValidaCampos(Sender: TWinControl;
      blnBuscaPorChave: Boolean = True): Boolean; override;
    function fRetPrecoVenda(intOpcao: Integer): Double;
    function fGetItemJaRelacionado(): Boolean;
  public
    constructor Create(AOwner: TComponent; cadastro: ICadastroTintaBaseAutomotiva);
      reintroduce; virtual;
    { Public declarations }
  end;

var
  frmCadTintasBasesAutomotiva: TfrmCadTintasBasesAutomotiva;

implementation

uses untFuncTinta, untFuncoesSimples, untConsultas, untTypesSistema,
  untValidarBaseItemAmarracao;

{$R *.dfm}

{ TfrmCadastroTintaBaseAutomotiva }

constructor TfrmCadTintasBasesAutomotiva.Create(AOwner: TComponent;
  cadastro: ICadastroTintaBaseAutomotiva);
begin
  Self.cadastro := cadastro;
  Self.consulta := cadastro.fGetConsulta;
  Inherited Create(AOwner, cadastro);

  pCriarDataSets;
  pLigarDataSets;
  pConfigurarLabels;
  pSetaCamposChaves;
  pSetaEnableReadOnly(qryCadastro);

  Caption := 'Cadastro de Bases - ' + cadastro.fGetNomeTinta;
end;

procedure TfrmCadTintasBasesAutomotiva.pCriarDataSets;
begin
  inherited pCriarDataSets;

  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoCusto)).DisplayFormat := '0.00';
  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoCusto)).EditFormat := '0.00';
  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoVenda)).DisplayFormat := '0.00';
  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoVenda)).EditFormat := '0.00';
  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoMargem)).DisplayFormat := '0.00';
  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoMargem)).EditFormat := '0.00';
  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoEmbalagem)).EditFormat := '0.00';
  TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoEmbalagem)).DisplayFormat := '0.00';
  If Not fEmptyStr(cadastro.fGetCampoPesoEspecifico) Then
  Begin
    TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoPesoEspecifico)).EditFormat := '0.0000';
    TFloatField(qryCadastro.FieldByName(cadastro.fGetCampoPesoEspecifico)).DisplayFormat := '0.0000';
  End;
end;

procedure TfrmCadTintasBasesAutomotiva.pLigarDataSets;
begin
  inherited pLigarDataSets;
  pLigarDataSets(dbeCodigo, lblCodigo, cadastro.fGetCampoCodigo);
  pLigarDataSets(dbeDescricao, lblDescricao, cadastro.fGetCampoDescricao);
  pLigarDataSets(dbeEmbalagem, lblEmbalagem, cadastro.fGetCampoEmbalagem);
  pLigarDataSets(dbePesoEspecifico, lblPesoEspecifico, cadastro.fGetCampoPesoEspecifico);
  pLigarDataSets(dbeCodigoItem, lblCodigoItem, cadastro.fGetCampoCodItem);
  pLigarDataSets(dbePrecoCusto, lblPrecoCusto, cadastro.fGetCampoCusto);
  pLigarDataSets(dbeMargem, lblMargem, cadastro.fGetCampoMargem);
  pLigarDataSets(dbePrecoVenda, lblPrecoVenda, cadastro.fGetCampoVenda);
end;

procedure TfrmCadTintasBasesAutomotiva.btnRestPrecoClick(
  Sender: TObject);
  Var
    fltPrecus: Double;
    fltMargem: Double;
    fltPreVen: Double;
begin
  inherited;
  pRetornaPrecos(dbeCodigoItem.Text, fltPrecus, fltMargem, fltPreVen);
  dbePrecoCusto.Field.AsFloat := fltPrecus;
  dbeMargem.Field.AsFloat := fltMargem;
  dbePrecoVenda.Field.AsFloat := fltPreVen;
end;

procedure TfrmCadTintasBasesAutomotiva.btnPesquisaClick(
  Sender: TObject);
  Var
    strSql: String;
    Key: Char;
    arrSel: TConsultasArray;
begin
  Key := '/';
  strSql := cadastro.fGetConsulta.fGetSelect(False);

  If fPesqGenericaTinta(Self, cadastro.fGetNomeTabela, qryTabela, Key, arrSel, True, cadastro.fGetCampoCadIteCodIte, '', False) Then
  Begin
    pSetFocus(btnAlterar);
  End;

  pCarregaItem;
end;

procedure TfrmCadTintasBasesAutomotiva.pAcertaCnvMl;
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text := cadastro.fGetSqlUpdateCnvMl;
      qryGen.ExecSQL;
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

procedure TfrmCadTintasBasesAutomotiva.pCarregaItem;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Text := 'SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = :CODITE';
  qryGen.ParamByName('CODITE').AsString := dbeCodigoItem.Text;
  qryGen.Open;

  edtDescricaoItem.Text := qryGen.FieldByName('ITE_DESITE').AsString;
  
  FreeAndNil(qryGen);
end;

procedure TfrmCadTintasBasesAutomotiva.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pCarregaItem;
  
  If dbeCodigo.CanFocus Then
    pSetFocus(dbeCodigo)
  Else If dbeDescricao.CanFocus Then
    pSetFocus(dbeDescricao);
    
  pSetaEnableReadOnly(qryCadastro);
end;

procedure TfrmCadTintasBasesAutomotiva.btnExcluirClick(Sender: TObject);
begin
  StrCodIteAnt := dbeCodigoItem.Text;
  inherited;

  if fEmptyStr(dbeCodigoItem.Text) Then
    pEnviarLogRep(strCodIteAnt, cadastro.fGetIdePro);

  pCarregaItem;
  pSetaEnableReadOnly(qryCadastro);
end;

procedure TfrmCadTintasBasesAutomotiva.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaItem;
  pSetaEnableReadOnly(qryCadastro);
end;

procedure TfrmCadTintasBasesAutomotiva.btnAlterarClick(Sender: TObject);
begin
  StrCodIteAnt := dbeCodigoItem.text;
  inherited;
  pSetaEnableReadOnly(qryCadastro);
  pDesabilitaCamposChaves;

  If dbeCodigo.CanFocus Then
    pSetFocus(dbeCodigo)
  Else If dbeDescricao.CanFocus Then
    pSetFocus(dbeDescricao)
  Else If dbeEmbalagem.CanFocus Then
    pSetFocus(dbeEmbalagem)
  Else If dbePesoEspecifico.CanFocus Then
    pSetFocus(dbePesoEspecifico);
end;

procedure TfrmCadTintasBasesAutomotiva.pConfigurarLabels;
begin
  lblCodigo.Caption := cadastro.fGetLabelCodigo + ':';
  lblDescricao.Caption := cadastro.fGetLabelDescricao + ':';
  lblEmbalagem.Caption := cadastro.fGetLabelEmbalagem + ':';
  lblPesoEspecifico.Caption := cadastro.fGetLabelPesoEspecifico + ':';
  lblCodigoItem.Caption := cadastro.fGetLabelCodItem + ':';
  lblPrecoCusto.Caption := cadastro.fGetLabelCusto + ':';
  lblMargem.Caption := cadastro.fGetLabelMargem + ':';
  lblPrecoVenda.Caption := cadastro.fGetLabelVenda + ':';
end;

procedure TfrmCadTintasBasesAutomotiva.dbeCodigoItemExit(
  Sender: TObject);
begin
  inherited;
  If Not dbeCodigoItem.ReadOnly Then
  Begin
    pCarregaItem;
  End;
end;

procedure TfrmCadTintasBasesAutomotiva.btnGravarClick(Sender: TObject);
Var
  ObjValidarBaseItemAmarracao : TValidarBaseItemAmarracao;
  blnEdit : Boolean;
begin
  ObjValidarBaseItemAmarracao := TValidarBaseItemAmarracao.Create;

  blnEdit := (qryCadastro.State in [dsEdit]);

  if ObjValidarBaseItemAmarracao.fValidarBaseItemAmarracao(cadastro.fGetIdePro, dbeCodigo.text, dbeDescricao.text, dbeCodigoItem.Text , StrCodIteAnt ,
                                fStrToFloat(dbePesoEspecifico.Text) , fStrToFloat(dbeEmbalagem.Text) ) Then
  Begin

    inherited;
    pSetaEnableReadOnly(qryCadastro);
    pAcertaCnvMl;

    If (Not fEmptyStr(strCoditeAnt)) And (blnEdit) Then
    Begin
      If (strCoditeAnt <> dbeCodigoItem.Text) Then
        pEnviarLogRep(strCodIteAnt, cadastro.fGetIdePro);
    End;


  End;

  If Assigned(ObjValidarBaseItemAmarracao)Then
    FreeAndNil(ObjValidarBaseItemAmarracao);

end;

procedure TfrmCadTintasBasesAutomotiva.pSetaEnableReadOnly(
  DataSet: TDataSet);
begin
  inherited pSetaEnableReadOnly(DataSet);
  Try
    btnRestPreco.Visible := qryCadastro.State = dsEdit;
    edtDescricaoItem.ReadOnly := True;
    dbePesoEspecifico.ReadOnly := (DataSet.State in [dsEdit]);
    If cadastro.fGetIdePro = 'LAZ' Then
    Begin
      dbePesoEspecifico.Visible := (DataSet.State in [dsInsert]);
      lblPesoEspecifico.Visible := (DataSet.State in [dsInsert]);
      dbePesoEspecifico.Tag := IIF(DataSet.State in [dsInsert], 99, 0);      
    End;
  Except
  End;
end;

procedure TfrmCadTintasBasesAutomotiva.FormShow(Sender: TObject);
begin
  inherited;
  pSetaEnableReadOnly(qryCadastro);
end;

procedure TfrmCadTintasBasesAutomotiva.dbeCodigoItemKeyPress(
  Sender: TObject; var Key: Char);
begin
  If (Not dbeCodigoItem.ReadOnly) And (fEntraCons(Key)) Then
  Begin
    pConsultaItemKeyPress(Sender, Key);
    pCarregaItem;
    btnRestPreco.Click;
  End;
end;

function TfrmCadTintasBasesAutomotiva.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  If (fEmptyStr(dbeCodigoItem.Text) And (fInComponents(Sender, [dbePrecoCusto, dbeMargem, dbePrecoVenda]))) Then
  Begin
    Result := True;
    Exit;
  End;

  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Sender = dbePrecoCusto Then
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
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmCadTintasBasesAutomotiva.fRetPrecoVenda(
  intOpcao: Integer): Double;
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

function TfrmCadTintasBasesAutomotiva.fGetItemJaRelacionado: Boolean;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'SELECT COUNT(*)    QTD FROM ' +
                cadastro.fGetNomeTabela +
                ' WHERE ' +
                cadastro.fGetCampoCodItem + ' = "' +
                dbeCodigoItem.Text + '"' +
                ' AND AUTOINCREM <> ' +
                AnsiQuotedStr(qryCadastro.FieldByName('AUTOINCREM').AsString, '"');
  qryGen.Open;
  Result := qryGen.FieldByName('QTD').AsInteger > 0;
  FreeAndNil(qryGen);
end;

end.

