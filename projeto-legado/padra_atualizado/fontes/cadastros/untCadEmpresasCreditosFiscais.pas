unit untCadEmpresasCreditosFiscais;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdenaEdit, DBCtrls, DBEditFocus, DB, DBClient, Provider,
  AppEvnts, Menus, StdCtrls, EditFocus, Mask, MaskEditFocus, Grids, DBGridCitel, DBGrids,
  ComCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls, UniClientDataSet,
  UniDataSetProvider, MemDS, DBAccess, Uni, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadEmpresasCreditosFiscais = class(TfrmPaiOrdenaEdit)
    Label2: TLabel;
    dbeMesRef: TDBEditFocus;
    dbeIcmAnt: TDBEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    dbeIpiAnt: TDBEditFocus;
    dbePisAnt: TDBEditFocus;
    Label5: TLabel;
    dbeCofAnt: TDBEditFocus;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure cdsConsultaAfterOpen(DataSet: TDataSet);
    procedure cdsConsultaAfterInsert(DataSet: TDataSet);
    procedure btnAlterarClick(Sender: TObject);
  private
    { Private declarations }
    function fMesJaDigitado: Boolean;
  protected
    function fGetSql(blnLike: Boolean): String;override;
    function fGetOrderBy: String; override;
    function fSetParametros: Boolean; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strEmpresaEdicao: String;
  end;


implementation

uses untFuncoesSimples, StrUtils;

{$R *.dfm}

procedure TfrmCadEmpresasCreditosFiscais.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeMesRef.ReadOnly := True;
  pSetFocus(dbeIcmAnt);
end;

procedure TfrmCadEmpresasCreditosFiscais.btnGravarClick(Sender: TObject);
begin
  cdsConsulta.FieldByName('CRE_CODEMP').AsString := strEmpresaEdicao;
  inherited;

  If blnGravou Then
  Begin
    blnGravou := False;
    dbeMesRef.ReadOnly := False;
  End;
end;

procedure TfrmCadEmpresasCreditosFiscais.cdsConsultaAfterInsert(
  DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('CRE_ICMANT').AsFloat := 0;
  DataSet.FieldByName('CRE_IPIANT').AsFloat := 0;
  DataSet.FieldByName('CRE_PISANT').AsFloat := 0;
  DataSet.FieldByName('CRE_COFANT').AsFloat := 0;
end;

procedure TfrmCadEmpresasCreditosFiscais.cdsConsultaAfterOpen(DataSet: TDataSet);
begin
  inherited;
  cdsConsulta.FieldByName('CRE_MESREF').EditMask := '99/9999;0;_';
end;

function TfrmCadEmpresasCreditosFiscais.fGetOrderBy: String;
begin
  Result := '';
  Result := Result + ' ORDER BY CRE_MESREF DESC ';
end;

function TfrmCadEmpresasCreditosFiscais.fGetSql(blnLike: Boolean): String;
begin
  Result := '';
  Result := 'SELECT CREFIS.*, CAST(IFNULL(RIGHT(AUTOINCREM, 17), 0) AS UNSIGNED) AS CRE_SEQIND FROM CREFIS WHERE CRE_CODEMP = :CODEMP ';
end;

function TfrmCadEmpresasCreditosFiscais.fMesJaDigitado: Boolean;
  Var
    qryAux: TUniQuery;
begin
  Result := False;
  If cdsConsulta.State <> dsInsert Then
  Begin
    Exit;
  End;

  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT COUNT(*) AS QTD FROM CREFIS WHERE CRE_CODEMP = :CODEMP AND CRE_MESREF = :MESREF');
  qryAux.ParamByName('CODEMP').AsString := strEmpresaEdicao;
  qryAux.ParamByName('MESREF').AsString := dbeMesRef.Text;
  qryAux.Open;

  Result := (qryAux.FieldByName('QTD').AsInteger > 0);

  FreeAndNil(qryAux);
end;

procedure TfrmCadEmpresasCreditosFiscais.FormCreate(Sender: TObject);
begin
  inherited;
  strNomTab := 'CREFIS';
  strCamChave  := 'CRE_SEQIND';
  blnTemSelecao := False;
  blnSelecionaComEspaco := False;

  blnAutoCommit := True;
end;

function TfrmCadEmpresasCreditosFiscais.fSetParametros: Boolean;
begin
  Result := inherited fSetParametros;
  qryConsulta.ParamByName('CODEMP').AsString := strEmpresaEdicao;
end;

function TfrmCadEmpresasCreditosFiscais.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;

  function fValidaValor(dbeEdit: TDBEditFocus; strCampo: String): Boolean;
  begin
    Result := True;
    If (fEmptyStr(dbeEdit.Text)) Or (fStrToFloat(dbeEdit.Text) < 0) Then
    Begin
      pMensagemOk('O ' + strCampo + ' crédito do mês não pode ser vazio e deve ser maior ou igual a Zero.');
      Result := False;
    End;
  end;

  function fValidaMesRef: Boolean;
    Var
      strMes: String;
  Begin
    strMes := LeftStr(dbeMesRef.Text,2);

    Result := True;

    If (StrToIntDef(strMes,0) <= 0) Or (StrToIntDef(strMes,0) > 12) Then
      Result := False;
  End;

begin
  Result := True;

  If Not inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    Result := False;
    Exit;
  End;

  If (Sender = dbeMesRef) Then
  Begin
    If fEmptyStr(fTiraCaracEspeciais(dbeMesRef.Text)) Then
    Begin
      pMensagemOk('O mês de referência não pode ser vazio.');
      Result := False;
    End
    Else If Not fValidaMesRef Then
    Begin
      pMensagemOk('O mês de referência deve estar entre 01 e 12.');
      Result := False;
    End
    Else If fMesJaDigitado Then
    Begin
      pMensagemOk('Este mês de referência já foi digitado.');
      Result := False;
    End;
  End
  Else If (Sender = dbeIcmAnt) Then
  Begin
    Result := fValidaValor(dbeIcmAnt, 'ICMS');
  End
  Else If (Sender = dbeIpiAnt) Then
  Begin
    Result := fValidaValor(dbeIpiAnt, 'IPI');
  End
  Else If (Sender = dbePisAnt) Then
  Begin
    Result := fValidaValor(dbePisAnt, 'PIS');
  End
  Else If (Sender = dbeCofAnt) Then
  Begin
    Result := fValidaValor(dbeCofAnt, 'COFINS');
  End;

  If Not Result Then
    pSetFocus(Sender);
   
end;

end.
