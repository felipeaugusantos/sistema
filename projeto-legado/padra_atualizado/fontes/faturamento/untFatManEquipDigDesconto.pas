unit untFatManEquipDigDesconto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.StdCtrls, EditFocus,
  Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.ComCtrls, Vcl.Buttons, BitBtnLockedIncrem;

type
  TfrmFatManEquipDigDesconto = class(TfrmPaiSimples)
    pnlPrincipal: TPanel;
    pnlResumo: TPanel;
    pnlTopDesEsp: TPanel;
    lblDesEsp: TLabel;
    Shape1: TShape;
    lblTotal: TLabel;
    pnlDadosGerais: TPanel;
    lblTotPro: TLabel;
    lblTotSer: TLabel;
    lblTotCon: TLabel;
    pnlTopDadosGerais: TPanel;
    lblInfGerais: TLabel;
    Shape2: TShape;
    pnlDesEsp: TPanel;
    lblPerDes: TLabel;
    lblTotDes: TLabel;
    lblValDes: TLabel;
    Panel2: TPanel;
    lblTopDesEsp: TLabel;
    Shape3: TShape;
    pnlConfirma: TPanel;
    btnCancelaDados: TBitBtnLocked;
    btnConfirmaDados: TBitBtnLocked;
    edtTotPro: TEditFocus;
    edtTotSer: TEditFocus;
    edtTotCon: TEditFocus;
    edtPerDes: TEditFocus;
    edtTotPerDes: TEditFocus;
    edtValDes: TEditFocus;
    edtTotal: TEditFocus;
    edtTotDes: TEditFocus;
    Label1: TLabel;
    Panel1: TPanel;
    lblAplicarDesconto: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure btnCancelaDadosClick(Sender: TObject);
  private
    { Private declarations }
    function fRetVlrProdSer: Double;
    function fRetTextoMensagem: String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    fltVlrPro: Double;
    fltVlrSer: Double;
    fltVlrCon: Double;
    fltPorDes: Double;
    fltValDes: Double;
    intOpcDesconto: Integer;

    fltDesEsp: Double;
  end;

CONST
  DESC_PRODSERV = 0;
  DESC_PROD = 1;
  DESC_SERV = 2;

var
  frmFatManEquipDigDesconto: TfrmFatManEquipDigDesconto;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmFatManEquipDigDesconto.btnCancelaDadosClick(Sender: TObject);
begin
  inherited;

  Close();
end;

procedure TfrmFatManEquipDigDesconto.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;

  If (Not fVerificaCampos()) Then Exit;

  fltPorDes := fStrToFloat(edtPerDes.Text);
  fltValDes := fStrToFloat(edtValDes.Text);

  Close();

  ModalResult := mrOk;
end;

procedure TfrmFatManEquipDigDesconto.FormShow(Sender: TObject);
  Var
    strMascara: String;
begin
  inherited;

  strMascara := fMskDigitos(2);

  fltVlrCon      := fltVlrPro + fltVlrSer;
  edtTotPro.Text := FormatFloat(strMascara, fltVlrPro);
  edtTotSer.Text := FormatFloat(strMascara, fltVlrSer);
  edtTotCon.Text := FormatFloat(strMascara, fltVlrCon);

  edtPerDes.Text := FormatFloat(strMascara, fltPorDes);
  edtTotPerDes.Text := FormatFloat(strMascara, 0);
  edtValDes.Text := FormatFloat(strMascara, fltValDes);
  edtTotDes.Text := FormatFloat(strMascara, 0);

  edtTotal.Text  := FormatFloat(strMascara, fltVlrCon);

  case intOpcDesconto of
    DESC_PRODSERV: lblAplicarDesconto.Caption := 'Aplicando desconto nos produtos e serviços';
    DESC_PROD:     lblAplicarDesconto.Caption := 'Aplicando desconto somente nos produtos';
    DESC_SERV:     lblAplicarDesconto.Caption := 'Aplicando desconto somente nos serviços';
  end;

  fVerificaCampos();

  pSetFocus(edtPerDes);
end;

function TfrmFatManEquipDigDesconto.fRetTextoMensagem: String;
begin
  Result := 'e serviços';
end;

function TfrmFatManEquipDigDesconto.fRetVlrProdSer: Double;
begin
  Result := fltVlrPro + fltVlrSer;
end;

function TfrmFatManEquipDigDesconto.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strMascara: String;
    fltPerDes: Double;
    fltValDes,
    fltDesSer: Double;
begin
  Result := True;

  strMascara := fMskDigitos(2);

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtPerDes) Then
    Begin
      If (Not fEmptyStr(edtPerDes.Text)) And (fStrToFloat(edtPerDes.Text) > 100) Then
      Begin
        pMensagemOk('Percentual de desconto deve ser de até 100%!');
        edtPerDes.Text := '0,00';
        edtTotPerDes.Text := '0,00';
        Result := False;
      End
      Else If (Not fEmptyStr(edtPerDes.Text)) And (fStrToFloat(edtPerDes.Text) < 0) Then
      Begin
        pMensagemOk('Percentual de desconto deve ser maior ou igual a zero!');
        edtPerDes.Text := '0,00';
        edtTotPerDes.Text := '0,00';
        Result := False;
      End;
    End

    Else If (Sender = edtValDes) Then
    Begin
      If (Not fEmptyStr(edtValDes.Text)) then
      begin
        If (fStrToFloat(edtValDes.Text) < 0) Then
        Begin
          pMensagemOk('Valor de desconto deve ser maior ou igual a zero!');
          edtValDes.Text := '0,00';
          Result := False;
        End
        else if (intOpcDesconto = DESC_PROD) and (fStrToFloat(edtValDes.Text) > fltVlrPro) then
        begin
          pMensagemOk('Valor de desconto não deve ser maior que o valor dos produtos da O.S.!');
          edtValDes.Text := '0,00';
          Result := False;
        end
        else if (intOpcDesconto = DESC_SERV) and (fStrToFloat(edtValDes.Text) > fltVlrSer) then
        begin
          pMensagemOk('Valor de desconto não deve ser maior que o valor dos serviços da O.S.!');
          edtValDes.Text := '0,00';
          Result := False;
        end
        else if (intOpcDesconto = DESC_PRODSERV) and (fStrToFloat(edtValDes.Text) > fRetVlrProdSer()) then
        begin
          pMensagemOk('Valor de desconto não deve ser maior que o valor dos produtos ' + fRetTextoMensagem() + ' da O.S.!');
          edtValDes.Text := '0,00';
          Result := False;
        end;
      end;
    End;

    If (fltDesEsp > fRetVlrProdSer()) Then
    Begin
      pMensagemOk('Valor de desconto não deve ser maior que o valor dos produtos ' + fRetTextoMensagem() + ' da O.S.!');
      edtValDes.Text := '0,00';
      edtPerDes.Text := '0,00';
      edtTotDes.Text := '0,00';
      edtTotPerDes.Text := '0,00';

      edtTotal.Text  := FormatFloat(strMascara, fltVlrCon);

      fltDesEsp := 0;
      Result := False;
    End;

    If Result then
    Begin
      fltDesEsp := 0;
      fltDesSer := 0;
      fltPerDes := fStrToFloat(edtPerDes.Text);

      if intOpcDesconto in [DESC_PRODSERV, DESC_PROD] then
      begin
        fltDesEsp := (fltPerDes / 100) * fltVlrPro;
        fltDesEsp := fTruncaFloat(fltDesEsp, 2);
      end;

      if intOpcDesconto in [DESC_PRODSERV, DESC_SERV] then
      begin
        fltDesSer := (fltPerDes / 100) * fltVlrSer;
        fltDesSer := fTruncaFloat(fltDesSer, 2);
      end;

      edtTotPerDes.Text := FormatFloat(strMascara, fltDesEsp + fltDesSer);

      fltValDes := fStrToFloat(edtValDes.Text);
      fltDesEsp := fltDesEsp + fltValDes;

      edtTotDes.Text := FormatFloat(strMascara, fltDesEsp + fltDesSer);
      edtTotal.Text  := FormatFloat(strMascara, fltVlrCon - fltDesEsp - fltDesSer);
    end;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
