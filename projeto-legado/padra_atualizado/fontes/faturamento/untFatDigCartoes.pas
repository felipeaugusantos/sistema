{***************************}
{* qryCadCar -> CADCAR     *}
{************************RV*}
unit untFatDigCartoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, ComCtrls, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Mask, MaskEditFocus, Menus, AppEvnts, Uni, strUtils,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmFatDigCartoes = class(TfrmPaiSimples)
    pnlCentral: TPanel;
    btnConfirma: TBitBtnLocked;
    Label3: TLabel;
    edtCodCar: TEditFocus;
    edtDesCar: TEditFocus;
    Label9: TLabel;
    edtQtdPar: TEditFocus;
    procedure btnSairClick(Sender: TObject);
    procedure edtCodCarKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    qryCadCar: TUniQuery;
    blnConfirma: Boolean;
    strCondicaoPagamentoVenda: String;
    procedure pCarregaCartao;
  end;

var
  frmFatDigCartoes: TfrmFatDigCartoes;

implementation

uses untFuncoesSimples, untPesqAux, untPai, untTypesSistema,
     untConsultas;

{$R *.dfm}

procedure TfrmFatDigCartoes.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TfrmFatDigCartoes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    intQtdParcelasVenda: Integer;
begin

  Result := True;

  intQtdParcelasVenda := strToIntDef(LeftStr(strCondicaoPagamentoVenda, 2), 0);

  If (Sender = edtCodCar) And (edtCodCar.Enabled) Then
  Begin

    If (fEmptyStr(edtCodCar.Text)) Then
    Begin
      fMensagem('', 'O código do cartão deve ser preenchida!', ['&Ok']);
      Result := False;
    End
    Else
    Begin

      If blnBuscaPorChave Then
        pCarregaCartao;

      If qryCadCar.FieldByName('CAR_STATUS').AsString = 'N' Then
      Begin
        fMensagem('', 'Esse cartão está inativo!', ['&Ok']);
        Result := False;
      End
      Else If (qryCadCar.FieldByName('CAR_CODCAR').IsNull) Then
      Begin
        fMensagem('', 'Esse cartão não está cadastrado!', ['&Ok']);
        Result := False;
      End
      Else If (Not fEmptyStr(qryCadCar.FieldByName('CAR_CODEMP').AsString))   And
              (qryCadCar.FieldByName('CAR_CODEMP').AsString <> VS_strCodEmp) Then
      Begin
        fMensagem('', 'Cartão da empresa (' + qryCadCar.FieldByName('CAR_CODEMP').AsString + '), ' +
          'portanto não pode ser utilizado.', ['&Ok']);
        Result := False;
      End
      Else If (fCfgSis('OBRCND', varBoolean)) And
              (intQtdParcelasVenda > 0) And
              (intQtdParcelasVenda < qryCadCar.FieldByName('CAR_SUGPAR').AsInteger) Then
      Begin
        fMensagem('', 'Condição de pagamento da venda possui ' + intQtdParcelasVenda.ToString +
          ' parcelas. Este cartão não pode ser selecionado pois exige no mínimo ' +
          qryCadCar.FieldByName('CAR_SUGPAR').AsString + ' parcelas!', ['&Ok']);
        Result := False;
      End
      Else If (fCfgSis('OBRCND', varBoolean)) And
              (intQtdParcelasVenda > 0) And
              (intQtdParcelasVenda > qryCadCar.FieldByName('CAR_MAXPAR').AsInteger) Then
      Begin
        fMensagem('', 'Condição de pagamento da venda possui ' + intQtdParcelasVenda.ToString +
          ' parcelas. Este cartão não pode ser selecionado pois permite no máximo ' +
          qryCadCar.FieldByName('CAR_MAXPAR').AsString + ' parcelas!', ['&Ok']);
        Result := False;
      End;
    End;

  End

  Else If (Sender = edtQtdPar) And (edtQtdPar.Enabled) Then
  Begin
    fValidaCampos(edtCodCar, False);

    If (fEmptyStr(edtQtdPar.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A quantidade de parcelas deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else If (StrToIntDef(edtQtdPar.Text,0) <= 0) Then
    Begin
      fMensagem('ATENÇÃO!', 'A quantidade de parcelas deve ser maior que Zero!', ['&Ok']);
      Result := False;
    End

    Else If (qryCadCar.FieldByName('CAR_MAXPAR').AsInteger > 0) And
            (StrToIntDef(edtQtdPar.Text,0) > qryCadCar.FieldByName('CAR_MAXPAR').AsInteger) Then
    Begin
      fMensagem('ATENÇÃO!', 'A quantidade de parcelas deve ser menor ou igual a ' + qryCadCar.FieldByName('CAR_MAXPAR').AsString + '!', ['&Ok']);
      Result := False;
    End

    Else If (qryCadCar.FieldByName('CAR_SUGPAR').AsInteger > 0) And
            (StrToIntDef(edtQtdPar.Text,0) < qryCadCar.FieldByName('CAR_SUGPAR').AsInteger) Then
    Begin
      fMensagem('ATENÇÃO!', 'A quantidade de parcelas deve ser maior ou igual a ' + qryCadCar.FieldByName('CAR_SUGPAR').AsString + '!', ['&Ok']);
      Result := False;
    End

    Else If (StrToIntDef(edtQtdPar.Text,0) > fCfgSis('PARCAR', varInteger)) Then
    Begin
      fMensagem('ATENÇÃO!', 'A quantidade de parcelas deve ser menor ou igual a ' + fCfgSis('PARCAR') + '!', ['&Ok']);
      Result := False;
    End

    Else If (fCfgSis('OBRCND', varBoolean)) And
            (intQtdParcelasVenda > 0) And
            (intQtdParcelasVenda < StrToIntDef(edtQtdPar.Text,0)) Then
    Begin
      fMensagem('', 'Condição de pagamento da venda possui ' + intQtdParcelasVenda.ToString +
        ' parcelas, portanto não é permitido informar uma quantidade de parcelas superior!', ['&Ok']);
      Result := False;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmFatDigCartoes.edtCodCarKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCartao : TConsultasArray;
begin
  inherited;
  {*****************************}
  {* NOVA CONSULTA DE CARTOES  *}
  {**************************DP*}
  If fPesqCartao(Self, edtCodCar, edtDesCar, Nil, Key, arrCartao, True, True) Then
  Begin
      If (fValidaCampos(edtCodCar, True)) Then
        Self.SelectNext(ActiveControl, True, True);
    pCarregaCartao;
  End;

end;

procedure TfrmFatDigCartoes.pCarregaCartao;
begin
  pPesquisaCadCar(qryCadCar, qryCadCar, edtCodCar.Text);

  With qryCadCar Do
  Begin
    edtDesCar.Text := FieldByName('CAR_DESCAR').AsString;
  End;
end;

procedure TfrmFatDigCartoes.FormShow(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

procedure TfrmFatDigCartoes.btnConfirmaClick(Sender: TObject);
begin                             
  inherited;

  If (Not fVerificaCampos) Then
  Begin
    Exit;
  End;

  blnConfirma := True;
  Close;
end;

procedure TfrmFatDigCartoes.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadCar := fCriaQuery(Self);
end;

end.


