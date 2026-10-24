unit untQckCaixaE_F_J;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, ExtCtrls, RLReport, StrUtils, QRExport,
  MaskUtils;

type
  TfrmQckCaixaE_F_J = class(TForm)
    QckBoleto: TQuickRep;
    TitleBand1: TQRBand;
    LinhaHorizontal6: TQRShape;
    LinhaHorizontal5: TQRShape;
    LinhaHorizontal4: TQRShape;
    LinhaHorizontal3: TQRShape;
    LinhaHorizontal1: TQRShape;
    LinhaHorizontal2: TQRShape;
    LinhaVertical1: TQRShape;
    LinhaHorizontal7: TQRShape;
    LabelNrBanco: TQRLabel;
    LabelVencimento: TQRLabel;
    LinhaVertical2: TQRShape;
    LabelLocalPagamento: TQRLabel;
    LabelCedente: TQRLabel;
    LabelNomeCedente: TQRLabel;
    LabelAgenciaCodigoCedente: TQRLabel;
    LabelDataDocumento: TQRLabel;
    LabelNrDocumento: TQRLabel;
    LabelEspecieDoc: TQRLabel;
    LabelAceite: TQRLabel;
    LabelDataProcessamento: TQRLabel;
    LabelNossoNumero: TQRLabel;
    LabelUsoBanco: TQRLabel;
    LabelCarteira: TQRLabel;
    LabelEspecie: TQRLabel;
    LabelReal: TQRLabel;
    LabelQuantidade: TQRLabel;
    LabelValor: TQRLabel;
    LabelX: TQRLabel;
    LabelValorDocumento: TQRLabel;
    QRLabel1: TQRLabel;
    LabelDesconto: TQRLabel;
    LabelMoraMulta: TQRLabel;
    LabelValorCobrado: TQRLabel;
    LabelSacado: TQRLabel;
    LabelSacadorAvalista: TQRLabel;
    LabelCodigoBaixa: TQRLabel;
    LabelAutenticacaoMecanica: TQRLabel;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    LabelNomeTitular: TQRLabel;
    LabelEndereco: TQRLabel;
    LabelCidade: TQRLabel;
    QRShape1: TQRShape;
    LabelInformacao1: TQRLabel;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRShape6: TQRShape;
    QRShape8: TQRShape;
    QRShape10: TQRShape;
    QRShape12: TQRShape;
    QRShape16: TQRShape;
    QRShape17: TQRShape;
    QRLabel40: TQRLabel;
    QRShape25: TQRShape;
    QRLabel42: TQRLabel;
    QRShape9: TQRShape;
    QRImage2: TQRImage;
    QRShape13: TQRShape;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel50: TQRLabel;
    QRLabel51: TQRLabel;
    QRLabel56: TQRLabel;
    QRLabel54: TQRLabel;
    QRLabel57: TQRLabel;
    QRLabel58: TQRLabel;
    QRLabel59: TQRLabel;
    QRLabel60: TQRLabel;
    QRLabel61: TQRLabel;
    QRLabel62: TQRLabel;
    QRLabel63: TQRLabel;
    QRLabel64: TQRLabel;
    QRLabel65: TQRLabel;
    QRLabel66: TQRLabel;
    QRLabel68: TQRLabel;
    QRShape7: TQRShape;
    QRShape11: TQRShape;
    QRShape14: TQRShape;
    QRShape15: TQRShape;
    QRShape18: TQRShape;
    QRShape19: TQRShape;
    QRShape20: TQRShape;
    QRShape21: TQRShape;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRShape22: TQRShape;
    QRLabel9: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel25: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel28: TQRLabel;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel31: TQRLabel;
    QRLabel32: TQRLabel;
    QRLabel33: TQRLabel;
    QRLabel34: TQRLabel;
    QRShape23: TQRShape;
    QRShape24: TQRShape;
    QRLabel35: TQRLabel;
    QRLabel36: TQRLabel;
    QRLabel37: TQRLabel;
    QRShape26: TQRShape;
    QRLabel41: TQRLabel;
    QRShape27: TQRShape;
    QRShape29: TQRShape;
    QRShape30: TQRShape;
    QRShape31: TQRShape;
    QRShape32: TQRShape;
    QRShape33: TQRShape;
    QRShape34: TQRShape;
    QRShape35: TQRShape;
    QRLabel44: TQRLabel;
    QRShape36: TQRShape;
    QRLabel45: TQRLabel;
    QRImage1: TQRImage;
    QRShape37: TQRShape;
    QRLabel46: TQRLabel;
    QRLabel47: TQRLabel;
    QRLabel48: TQRLabel;
    QRLabel49: TQRLabel;
    QRLabel52: TQRLabel;
    QRLabel53: TQRLabel;
    QRLabel55: TQRLabel;
    QRLabel69: TQRLabel;
    QRLabel70: TQRLabel;
    QRLabel71: TQRLabel;
    QRLabel72: TQRLabel;
    QRLabel78: TQRLabel;
    QRLabel79: TQRLabel;
    QRLabel80: TQRLabel;
    QRLabel81: TQRLabel;
    QRLabel82: TQRLabel;
    QRLabel83: TQRLabel;
    QRLabel84: TQRLabel;
    InsSac: TQRLabel;
    QRLabel39: TQRLabel;
    QRLabel73: TQRLabel;
    QRLabel74: TQRLabel;
    QRLabel75: TQRLabel;
    QRLabel76: TQRLabel;
    QRLabel77: TQRLabel;
    QRLabel85: TQRLabel;
    QRLabel86: TQRLabel;
    QRLabel87: TQRLabel;
    QRLabel88: TQRLabel;
    QRLabel67: TQRLabel;
    QRLabel145: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel10: TQRLabel;
    QRShape38: TQRShape;
    QRShape39: TQRShape;
    QRShape40: TQRShape;
    QRShape41: TQRShape;
    QRShape42: TQRShape;
    QRShape43: TQRShape;
    QRShape44: TQRShape;
    QRShape45: TQRShape;
    QRLabel38: TQRLabel;
    QRLabel43: TQRLabel;
    QRShape46: TQRShape;
    QRLabel89: TQRLabel;
    QRLabel90: TQRLabel;
    QRLabel91: TQRLabel;
    QRLabel92: TQRLabel;
    QRLabel93: TQRLabel;
    QRLabel94: TQRLabel;
    QRLabel95: TQRLabel;
    QRLabel96: TQRLabel;
    QRLabel97: TQRLabel;
    QRLabel98: TQRLabel;
    QRLabel99: TQRLabel;
    QRLabel100: TQRLabel;
    QRLabel101: TQRLabel;
    QRLabel102: TQRLabel;
    QRLabel103: TQRLabel;
    QRLabel104: TQRLabel;
    QRLabel105: TQRLabel;
    QRLabel106: TQRLabel;
    QRLabel107: TQRLabel;
    QRLabel108: TQRLabel;
    QRLabel109: TQRLabel;
    QRLabel110: TQRLabel;
    QRLabel111: TQRLabel;
    QRLabel112: TQRLabel;
    QRLabel113: TQRLabel;
    QRLabel114: TQRLabel;
    QRShape47: TQRShape;
    QRShape48: TQRShape;
    QRLabel115: TQRLabel;
    QRLabel116: TQRLabel;
    QRLabel117: TQRLabel;
    QRShape49: TQRShape;
    QRLabel118: TQRLabel;
    QRShape50: TQRShape;
    QRShape51: TQRShape;
    QRShape52: TQRShape;
    QRShape53: TQRShape;
    QRShape54: TQRShape;
    QRShape55: TQRShape;
    QRShape56: TQRShape;
    QRShape57: TQRShape;
    QRLabel119: TQRLabel;
    QRShape58: TQRShape;
    QRLabel120: TQRLabel;
    QRShape59: TQRShape;
    QRImage3: TQRImage;
    QRShape60: TQRShape;
    QRLabel121: TQRLabel;
    QRLabel122: TQRLabel;
    QRLabel123: TQRLabel;
    QRLabel124: TQRLabel;
    QRLabel125: TQRLabel;
    QRLabel126: TQRLabel;
    QRLabel127: TQRLabel;
    QRLabel128: TQRLabel;
    QRLabel129: TQRLabel;
    QRLabel130: TQRLabel;
    QRLabel131: TQRLabel;
    QRLabel132: TQRLabel;
    QRLabel133: TQRLabel;
    QRLabel134: TQRLabel;
    QRLabel135: TQRLabel;
    QRLabel136: TQRLabel;
    QRLabel137: TQRLabel;
    QRLabel138: TQRLabel;
    QRLabel139: TQRLabel;
    QRLabel140: TQRLabel;
    QRLabel141: TQRLabel;
    QRLabel142: TQRLabel;
    QRLabel143: TQRLabel;
    QRLabel144: TQRLabel;
    QRLabel146: TQRLabel;
    QRLabel147: TQRLabel;
    procedure LabelNomeTitularPrint(sender: TObject; var Value: String);
    procedure LabelEnderecoPrint(sender: TObject; var Value: String);
    procedure LabelCidadePrint(sender: TObject; var Value: String);
    procedure LabelNomeTitular2Print(sender: TObject; var Value: String);
    procedure LabelEndereco2Print(sender: TObject; var Value: String);
    procedure LabelCidade2Print(sender: TObject; var Value: String);
    procedure LabelNomeTitular3Print(sender: TObject; var Value: String);
    procedure LabelEndereco3Print(sender: TObject; var Value: String);
    procedure LabelCidade3Print(sender: TObject; var Value: String);
    procedure LabelNomeCedentePrint(sender: TObject; var Value: String);
    procedure QRLabel50Print(sender: TObject; var Value: String);
    procedure QRLabel51Print(sender: TObject; var Value: String);
    procedure QRLabel56Print(sender: TObject; var Value: String);
    procedure QRLabel54Print(sender: TObject; var Value: String);
    procedure QRLabel42Print(sender: TObject; var Value: String);
    procedure QRLabel57Print(sender: TObject; var Value: String);
    procedure QRLabel58Print(sender: TObject; var Value: String);
    procedure QRLabel59Print(sender: TObject; var Value: String);
    procedure QRLabel60Print(sender: TObject; var Value: String);
    procedure QRLabel40Print(sender: TObject; var Value: String);
    procedure QRLabel61Print(sender: TObject; var Value: String);
    procedure QRLabel62Print(sender: TObject; var Value: String);
    procedure QRLabel63Print(sender: TObject; var Value: String);
    procedure QRLabel64Print(sender: TObject; var Value: String);
    procedure QRLabel65Print(sender: TObject; var Value: String);
    procedure QRLabel67Print(sender: TObject; var Value: String);
    procedure QRLabel68Print(sender: TObject; var Value: String);
    procedure QRLabel83Print(sender: TObject; var Value: String);
    procedure QRLabel84Print(sender: TObject; var Value: String);
    procedure QRLabel71Print(sender: TObject; var Value: String);
    procedure QRLabel66Print(sender: TObject; var Value: String);
    procedure QRLabel78Print(sender: TObject; var Value: String);
    procedure InsSacPrint(sender: TObject; var Value: String);
    procedure QRLabel6Print(sender: TObject; var Value: String);
    procedure QRLabel48Print(sender: TObject; var Value: String);
    procedure QRLabel73Print(sender: TObject; var Value: String);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
    strNovCed : String;

  public
    { Public declarations }
  end;

var
  frmQckCaixaE_F_J: TfrmQckCaixaE_F_J;

implementation

uses
   untFuncoesBoleto, untFuncoesSimples;

{$R *.dfm}

procedure TfrmQckCaixaE_F_J.LabelNomeTitularPrint(sender: TObject;
  var Value: String);
begin

  Value := strNomSac;

end;

procedure TfrmQckCaixaE_F_J.LabelEnderecoPrint(sender: TObject;
  var Value: String);
begin

  Value := strEndSac + ' - ' + strBaiSac;

end;

procedure TfrmQckCaixaE_F_J.LabelCidadePrint(sender: TObject;
  var Value: String);
begin

  Value := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac

end;

procedure TfrmQckCaixaE_F_J.LabelNomeTitular2Print(sender: TObject;
  var Value: String);
begin

	Value := strNomSac;

end;

procedure TfrmQckCaixaE_F_J.LabelEndereco2Print(sender: TObject;
  var Value: String);
begin

  Value := strEndSac + ' - ' + strBaiSac;

end;

procedure TfrmQckCaixaE_F_J.LabelCidade2Print(sender: TObject;
  var Value: String);
begin

  Value := fMaskCEP(strCep001) + ' ' + strCidSac + ' ' + strEstSac;

end;

procedure TfrmQckCaixaE_F_J.LabelNomeTitular3Print(sender: TObject;
  var Value: String);
begin

	Value := strNomSac;

end;

procedure TfrmQckCaixaE_F_J.LabelEndereco3Print(sender: TObject;
  var Value: String);
begin

  Value := strEndSac + ' - ' + strBaiSac;

end;

procedure TfrmQckCaixaE_F_J.LabelCidade3Print(sender: TObject;
  var Value: String);
begin

  Value := strCep001 + ' ' + strCidSac + ' ' + strEstSac;

end;


procedure TfrmQckCaixaE_F_J.LabelNomeCedentePrint(sender: TObject;
  var Value: String);
begin

  If strTipIns = '01' Then
    Value := strNomCed + '   ' + fMaskCNPJ(strNumIns)
  Else
    Value := strNomCed + '   ' +fMaskCPF(strNumIns);

end;

procedure TfrmQckCaixaE_F_J.QRLabel50Print(sender: TObject;
  var Value: String);
begin
  Value := FormatDateTime('dd/mm/yyyy', dtaDtaVen);

end;

procedure TfrmQckCaixaE_F_J.QRLabel51Print(sender: TObject;
  var Value: String);
begin
  Value := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);

end;

procedure TfrmQckCaixaE_F_J.QRLabel56Print(sender: TObject;
  var Value: String);
begin
  value := strNumDoc;
end;

procedure TfrmQckCaixaE_F_J.QRLabel54Print(sender: TObject;
  var Value: String);
begin
  Value := 'DM';
end;

procedure TfrmQckCaixaE_F_J.QRLabel42Print(sender: TObject;
  var Value: String);
begin
  If strIdeAce = 'A' Then
    Value := 'S'
  Else
    Value := 'N';
end;

procedure TfrmQckCaixaE_F_J.QRLabel57Print(sender: TObject;
  var Value: String);
begin

  Value := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
end;

procedure TfrmQckCaixaE_F_J.QRLabel58Print(sender: TObject;
  var Value: String);
begin

  //* SISTEMA DE COBRANÇA SICOB *//
  If Pos(strCodCar, '_11_12_14_41') >= 1 Then
  Begin

    strNovCed := strNumAge + LeftStr(strCodCed, 12);
    Insert('.',strNovCed, 5);
    Insert('.',strNovCed, 9);
    Insert('-',strNovCed, 18);
    Value := strNovCed;

  End

  // SISTEMA DE COBRANÇA SIGCB
  Else If Pos(strCodCar, '_24') > 0 Then
  Begin
    strNovCed := strNumAge + LeftStr(strCodCed, 6);
    Insert('.',strNovCed, 5);
    Value := strNovCed + '-' + strDigCed;
  End

  //* SISTEMA DE COBRANÇA SINCO nn16p *//
  Else If Pos(strCodCar, '_08') >= 1 Then
  Begin

    strNovCed := strNumAge + LeftStr(strCodCed, 12);
    Insert('.',strNovCed, 5);
    Insert('.',strNovCed, 9);
    Insert('-',strNovCed, 18);
    Value := strNovCed;

  End
  
  //* SISTEMA DE COBRANÇA SINCO *//
  Else If StrToInt(Trim(strCodCar)) = 01 Then
  Begin

    strNovCed := strNumAge + LeftStr(strCodCed, 6);
    Insert('.',strNovCed, 5);
    Value := strNovCed;

  End;

end;

procedure TfrmQckCaixaE_F_J.QRLabel59Print(sender: TObject;
  var Value: String);
begin

  Value := strNosNum;

end;

procedure TfrmQckCaixaE_F_J.QRLabel60Print(sender: TObject;
  var Value: String);
begin

  Value := FormatFloat('#,##0.00', fStrToFloat(LeftStr(strVlrTit, 8) + ',' + RightStr(strVlrTit, 2)));

end;

procedure TfrmQckCaixaE_F_J.QRLabel40Print(sender: TObject;
  var Value: String);
begin
  Value := strUsoBan;
end;

procedure TfrmQckCaixaE_F_J.QRLabel61Print(sender: TObject;
  var Value: String);
begin
   If Trim(strInstr1) <> '' Then
    Value := strInstr1;
end;

procedure TfrmQckCaixaE_F_J.QRLabel62Print(sender: TObject;
  var Value: String);
begin
  If Trim(strInstr2) <> '' Then
    Value := strInstr2;
end;

procedure TfrmQckCaixaE_F_J.QRLabel63Print(sender: TObject;
  var Value: String);
begin

  If Trim(strInstr3) <> '' Then
    Value := strInstr3;

end;

procedure TfrmQckCaixaE_F_J.QRLabel64Print(sender: TObject;
  var Value: String);
begin

  If Trim(strInstr4) <> '' Then
    Value := strInstr4;

end;

procedure TfrmQckCaixaE_F_J.QRLabel65Print(sender: TObject;
  var Value: String);
begin

  If Trim(strInstr5) <> '' Then
    Value := strInstr5;

end;

procedure TfrmQckCaixaE_F_J.QRLabel67Print(sender: TObject;
  var Value: String);
begin
  Value := strLinDig;
end;

procedure TfrmQckCaixaE_F_J.QRLabel68Print(sender: TObject;
  var Value: String);
begin
  Value := strCodBar;
end;

procedure TfrmQckCaixaE_F_J.QRLabel83Print(sender: TObject;
  var Value: String);
begin

  If fltVlrMor > 0 Then
    Value := 'APÓS O VENCIMENTO COBRAR JUROS DIÁRIOS DE ' + FormatFloat('R$ #,##0.00', fltVlrMor);

  If fltVlrMul > 0 Then
    Value := Trim(Value  + '        APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul));

end;

procedure TfrmQckCaixaE_F_J.QRLabel84Print(sender: TObject;
  var Value: String);
  Var
    intProtesto : Integer;
begin

  Try
    intProtesto := StrToInt(strPraPro);
  Except
    intProtesto := 0;
  End;

  If intProtesto = 1 Then
  Begin
    Value := 'PROTESTO AUTOMÁTICO APÓS ' + strPraPro + ' DIA CORRIDO, A CONTAR DA DATA DE VENCIMENTO';
  End
  Else If intProtesto > 1 Then
  Begin
    Value := 'PROTESTO AUTOMÁTICO APÓS ' + strPraPro + ' DIAS CORRIDOS, A CONTAR DA DATA DE VENCIMENTO';
  End;

end;

procedure TfrmQckCaixaE_F_J.QRLabel71Print(sender: TObject;
  var Value: String);
begin

  Value := strNosNum;

end;

procedure TfrmQckCaixaE_F_J.QRLabel66Print(sender: TObject;
  var Value: String);
begin

  Value := strNosNum;

end;

procedure TfrmQckCaixaE_F_J.QRLabel78Print(sender: TObject;
  var Value: String);
begin

  Value := strNosNum;

end;

procedure TfrmQckCaixaE_F_J.InsSacPrint(sender: TObject;
  var Value: String);
begin

  If (strNuInSa <> '') Then
  Begin

    If (Length(Trim(strNuInSa)) > 11) Then
      Value := 'CPF/CNPJ: ' + fMaskCNPJ(strNuInSa)
    Else
      Value := 'CPF/CNPJ: ' + fMaskCPF(strNuInSa);

  End;

end;

procedure TfrmQckCaixaE_F_J.QRLabel6Print(sender: TObject;
  var Value: String);
begin
  If Pos(strCodCar,'12_') > 0 Then
    Value := 'CR'
  Else If Pos(strCodCar,'14_24_') > 0 Then
    Value := 'SR'
  Else If Pos(strCodCar,'11_') > 0 Then
    Value := 'CS'
  Else If Pos(strCodCar,'_41') > 0 Then
    Value := 'DE'
  Else
    Value := strCodCar;

end;

procedure TfrmQckCaixaE_F_J.QRLabel48Print(sender: TObject;
  var Value: String);
begin
  If Pos(strCodCar,'12_') > 0 Then
    Value := 'CR'
  Else If Pos(strCodCar,'14_24_') > 0 Then
    Value := 'SR'
  Else If Pos(strCodCar,'11_') > 0 Then
    Value := 'CS'
  Else If Pos(strCodCar,'_41') > 0 Then
    Value := 'DE'
  Else
    Value := strCodCar;
end;

procedure TfrmQckCaixaE_F_J.QRLabel73Print(sender: TObject;
  var Value: String);
begin
  If fltVlrMor > 0 Then
    Value := 'NAO RECEBER O PRINCIPAL SEM JUROS DE MORA';

end;

procedure TfrmQckCaixaE_F_J.FormCreate(Sender: TObject);
begin

  If Pos(strCodCar, '_11_12_14_41') > 0 Then
  Begin
    strNosNum := strNosNum;
    Insert('-',strNosNum, 11);
  End

  // SISTEMA DE COBRANÇA SIGCB
  Else If Pos(strCodCar, '_24') > 0 Then
  Begin
    strNosNum := '24' + strNosNum;
    Insert('-',strNosNum, 18);
  End

  //* SISTEMA DE COBRANÇA SINCO nn16p*//
  Else If Pos(strCodCar, '_08') > 0 Then
  Begin
    strNosNum := '8' + fStrZero(strNosNum,15);
    Insert('-',strNosNum, 16);
  End

  //* SISTEMA DE COBRANÇA SINCO *//
  Else If StrToInt(Trim(strCodCar)) = 01 Then
  Begin
    strNosNum := '9000000' + strNosNum;
    Insert('.',strNosNum, 19);
  End;

  If Not( blnPegImp ) Then
    QckBoleto.Print
  Else
    QckBoleto.Preview;
  
end;

end.
