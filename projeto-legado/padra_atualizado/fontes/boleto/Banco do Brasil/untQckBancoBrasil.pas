unit untQckBancoBrasil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, ExtCtrls, RLReport, StrUtils, QRExport,
  MaskUtils;

type
  TfrmQckBancoBrasil = class(TForm)
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
    QRLabel10: TQRLabel;
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
    QRLabel80: TQRLabel;
    QRLabel81: TQRLabel;
    QRLabel82: TQRLabel;
    QRLabel83: TQRLabel;
    QRLabel84: TQRLabel;
    InsSac: TQRLabel;
    QRLabel39: TQRLabel;
    QRLabel74: TQRLabel;
    QRLabel75: TQRLabel;
    QRLabel76: TQRLabel;
    QRLabel77: TQRLabel;
    QRLabel85: TQRLabel;
    QRLabel86: TQRLabel;
    QRLabel87: TQRLabel;
    QRLabel41: TQRLabel;
    QRLabel2: TQRLabel;
    qrlLinDig: TQRLabel;
    QRShape28: TQRShape;
    QRShape38: TQRShape;
    QRShape39: TQRShape;
    QRShape40: TQRShape;
    QRShape41: TQRShape;
    QRShape42: TQRShape;
    QRShape43: TQRShape;
    QRShape44: TQRShape;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRShape45: TQRShape;
    QRLabel38: TQRLabel;
    QRLabel43: TQRLabel;
    QRLabel46: TQRLabel;
    QRLabel47: TQRLabel;
    QRLabel67: TQRLabel;
    QRLabel79: TQRLabel;
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
    QRShape46: TQRShape;
    QRShape47: TQRShape;
    QRLabel111: TQRLabel;
    QRLabel112: TQRLabel;
    QRLabel113: TQRLabel;
    QRShape48: TQRShape;
    QRShape49: TQRShape;
    QRShape50: TQRShape;
    QRShape51: TQRShape;
    QRShape52: TQRShape;
    QRShape53: TQRShape;
    QRShape54: TQRShape;
    QRShape55: TQRShape;
    QRShape56: TQRShape;
    QRLabel115: TQRLabel;
    QRShape57: TQRShape;
    QRLabel116: TQRLabel;
    QRImage3: TQRImage;
    QRShape58: TQRShape;
    QRLabel117: TQRLabel;
    QRLabel118: TQRLabel;
    QRLabel119: TQRLabel;
    QRLabel120: TQRLabel;
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
    QRLabel137: TQRLabel;
    qrBandaComprovante: TQRBand;
    QRShape61: TQRShape;
    QRLabel73: TQRLabel;
    QRLabel138: TQRLabel;
    QRShape62: TQRShape;
    QRLabel139: TQRLabel;
    QRLabel140: TQRLabel;
    QRShape59: TQRShape;
    QRLabel3: TQRLabel;
    QRShape60: TQRShape;
    QRImage4: TQRImage;
    QRLabel88: TQRLabel;
    QRShape63: TQRShape;
    QRLabel135: TQRLabel;
    QRLabel141: TQRLabel;
    QRShape64: TQRShape;
    QRLabel142: TQRLabel;
    QRLabel143: TQRLabel;
    QRShape65: TQRShape;
    QRLabel144: TQRLabel;
    QRShape66: TQRShape;
    QRShape67: TQRShape;
    QRLabel145: TQRLabel;
    QRLabel146: TQRLabel;
    QRLabel147: TQRLabel;
    QRShape68: TQRShape;
    QRLabel148: TQRLabel;
    QRLabel149: TQRLabel;
    QRLabel150: TQRLabel;
    QRShape69: TQRShape;
    QRLabel151: TQRLabel;
    QRLabel152: TQRLabel;
    QRLabel153: TQRLabel;
    QRLabel154: TQRLabel;
    QRLabel155: TQRLabel;
    QRLabel156: TQRLabel;
    QRLabel157: TQRLabel;
    QRShape70: TQRShape;
    QRLabel158: TQRLabel;
    QRLabel159: TQRLabel;
    QRShape71: TQRShape;
    QRLabel160: TQRLabel;
    QRShape72: TQRShape;
    QRShape73: TQRShape;
    QRLabel161: TQRLabel;
    QRLabel162: TQRLabel;
    QRLabel163: TQRLabel;
    QRShape74: TQRShape;
    QRShape75: TQRShape;
    QRShape76: TQRShape;
    QRShape77: TQRShape;
    QRLabel164: TQRLabel;
    QRLabel165: TQRLabel;
    QRLabel166: TQRLabel;
    QRShape78: TQRShape;
    QRShape79: TQRShape;
    QRLabel167: TQRLabel;
    QRLabel168: TQRLabel;
    QRLabel89: TQRLabel;
    QRLabel90: TQRLabel;
    QRLabel114: TQRLabel;
    QRLabel136: TQRLabel;
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
    procedure QRLabel70Print(sender: TObject; var Value: String);
    procedure QRLabel71Print(sender: TObject; var Value: String);
    procedure QRLabel66Print(sender: TObject; var Value: String);
    procedure QRLabel78Print(sender: TObject; var Value: String);
    procedure InsSacPrint(sender: TObject; var Value: String);
    procedure QRLabel6Print(sender: TObject; var Value: String);
    procedure QRLabel48Print(sender: TObject; var Value: String);
    procedure qrlLinDigPrint(sender: TObject; var Value: String);
    procedure FormCreate(Sender: TObject);
    procedure QckBoletoBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRLabel90Print(sender: TObject; var Value: string);
  private
    { Private declarations }
    strNossoNu: String;
    StrCedent: String;

  public
    { Public declarations }
  end;

var
  frmQckBancoBrasil: TfrmQckBancoBrasil;

implementation

uses
   untFuncoesBoleto, untFuncoesSimples;

{$R *.dfm}

procedure TfrmQckBancoBrasil.LabelNomeTitularPrint(sender: TObject;
  var Value: String);
begin

  Value := strNomSac;

end;

procedure TfrmQckBancoBrasil.LabelEnderecoPrint(sender: TObject;
  var Value: String);
begin

  Value := strEndSac + ' - ' + strBaiSac;

end;

procedure TfrmQckBancoBrasil.LabelCidadePrint(sender: TObject;
  var Value: String);
begin

  Value := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac

end;

procedure TfrmQckBancoBrasil.LabelNomeTitular2Print(sender: TObject;
  var Value: String);
begin

	Value := strNomSac;

end;

procedure TfrmQckBancoBrasil.LabelEndereco2Print(sender: TObject;
  var Value: String);
begin

  Value := strEndSac + ' - ' + strBaiSac;

end;

procedure TfrmQckBancoBrasil.LabelCidade2Print(sender: TObject;
  var Value: String);
begin

  Value := fMaskCEP(strCep001) + ' ' + strCidSac + ' ' + strEstSac;

end;

procedure TfrmQckBancoBrasil.LabelNomeTitular3Print(sender: TObject;
  var Value: String);
begin

	Value := strNomSac;

end;

procedure TfrmQckBancoBrasil.LabelEndereco3Print(sender: TObject;
  var Value: String);
begin

  Value := strEndSac + ' - ' + strBaiSac;

end;

procedure TfrmQckBancoBrasil.LabelCidade3Print(sender: TObject;
  var Value: String);
begin

  Value := strCep001 + ' ' + strCidSac + ' ' + strEstSac;

end;


procedure TfrmQckBancoBrasil.LabelNomeCedentePrint(sender: TObject;
  var Value: String);
begin

  If strTipIns = '01' Then
    Value := strNomCed + '   ' + fMaskCNPJ(strNumIns)
  Else
    Value := strNomCed + '   ' +fMaskCPF(strNumIns);

end;

procedure TfrmQckBancoBrasil.QRLabel50Print(sender: TObject;
  var Value: String);
begin
  Value := FormatDateTime('dd/mm/yyyy', dtaDtaVen);

end;

procedure TfrmQckBancoBrasil.QRLabel51Print(sender: TObject;
  var Value: String);
begin
  Value := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);

end;

procedure TfrmQckBancoBrasil.QRLabel56Print(sender: TObject;
  var Value: String);
begin
  value := strNumDoc;
end;

procedure TfrmQckBancoBrasil.QRLabel54Print(sender: TObject;
  var Value: String);
begin
  Value := strEspDoc;
end;

procedure TfrmQckBancoBrasil.QRLabel42Print(sender: TObject;
  var Value: String);
begin
  If strIdeAce = 'A' Then
    Value := 'S'
  Else
    Value := 'N';
end;

procedure TfrmQckBancoBrasil.QRLabel57Print(sender: TObject;
  var Value: String);
begin

  Value := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
end;

procedure TfrmQckBancoBrasil.QRLabel58Print(sender: TObject;
  var Value: String);
begin

  strCedent := strNumAge + strDigAge + fStrZero(strCodCed, 7);
  Insert('-', strCedent, 5);
  Insert('/', strCedent, 7);
  Insert(' ', strCedent, 8);
  Insert('-', strCedent, 15);

  Value := strCedent;

end;

procedure TfrmQckBancoBrasil.QRLabel59Print(sender: TObject;
  var Value: String);

begin

  If ((RightStr(Trim(strCodCar), 2) = '16') Or (RightStr(Trim(strCodCar), 2) = '18')) And (Length(strNumCon) <= 6) Then
  Begin

    If (RightStr(Trim(strCodCar), 2) = '18') Then
    Begin
      strNossoNu := fStrZero(Copy(strNosNum, 1, Length(strNosNum)-1),17);
      Value := strNossoNu;
    End
    Else
    Begin
      strNossoNu := strNumCon + strNosNum;
      Insert('.',strNossoNu, 4);
      Insert('.',strNossoNu, 8);
      Insert('.',strNossoNu, 12);
      Insert('.',strNossoNu, 16);
      Insert('.',strNossoNu, 20);
      Value := strNossoNu;
    End;

  End
  Else If ((RightStr(Trim(strCodCar), 2) = '18')) And (Length(strNumCon) >= 7) Then
  Begin

    strNossoNu := strNumCon + RightStr(Trim(strNosNum), 10);
    Insert('.',strNossoNu, 3);
    Insert('.',strNossoNu, 7);
    Insert('.',strNossoNu, 11);
    Insert('.',strNossoNu, 15);
    Insert('.',strNossoNu, 19);
    Value := strNossoNu;

  End
  Else If (RightStr(Trim(strCodCar), 2) = '17') And (Length(strNumCon) >= 7) Then
  Begin

    strNossoNu := strNumCon + strNosNum;
    //Insert('.',strNossoNu, 3);
    //Insert('.',strNossoNu, 7);
    //Insert('.',strNossoNu, 11);
    //Insert('.',strNossoNu, 15);
    //Insert('.',strNossoNu, 19);
    Value := strNossoNu;

  End
  Else If (RightStr(Trim(strCodCar), 2) = '17') And (Length(strNumCon) = 6) Then
  Begin

    strNossoNu := strNosNum;
    Insert('-',strNossoNu, 12);
    Value := strNossoNu;

  End
  Else If ((RightStr(Trim(strCodCar), 2) = '12')) Then
  Begin
    strNossoNu := strNumCon + strNosNum;
    Insert('.',strNossoNu, 12);
    Value := strNossoNu;

  End
  Else
  Begin

    strNossoNu := strNumCon + strNosNum;
    Insert('.',strNossoNu, 3);
    Insert('.',strNossoNu, 7);
    Insert('.',strNossoNu, 11);
    Insert('.',strNossoNu, 15);
    Insert('.',strNossoNu, 19);
    Value := strNossoNu;

  End;

end;

procedure TfrmQckBancoBrasil.QRLabel60Print(sender: TObject;
  var Value: String);
begin

  Value := FormatFloat('#,##0.00', fStrToFloat(LeftStr(strVlrTit, 8) + ',' + RightStr(strVlrTit, 2)));

end;

procedure TfrmQckBancoBrasil.QRLabel40Print(sender: TObject;
  var Value: String);
begin
//  Value := strUsoBan;
  Value := ''; //comentado dia 03/12/2008 por Ronasldo e Detinho.
end;

procedure TfrmQckBancoBrasil.QRLabel61Print(sender: TObject;
  var Value: String);
  Var
    fltValor: Double;
begin
  fltValor := fStrToFloat(LeftStr(strVlrTit, 8) + ',' + RightStr(strVlrTit, 2));
  fltValor := (fltValor * fltDesBol) / 100;

  If fltValor > 0 Then
    Value := 'CONCEDER DESCONTO DE R$ ' + FloatToStrF(fltValor, ffNumber, 12, 2) + ' SE PAGO ATÉ A DATA DO VENCIMENTO.'
  Else
    Value := '';
end;

procedure TfrmQckBancoBrasil.QRLabel62Print(sender: TObject;
  var Value: String);
begin
  If Trim(strInstr1) <> '' Then
    Value := strInstr1;
end;

procedure TfrmQckBancoBrasil.QRLabel63Print(sender: TObject;
  var Value: String);
begin

  If Trim(strInstr2) <> '' Then
    Value := strInstr2;

end;

procedure TfrmQckBancoBrasil.QRLabel64Print(sender: TObject;
  var Value: String);
begin

  If Trim(strInstr3) <> '' Then
    Value := strInstr3;

end;

procedure TfrmQckBancoBrasil.QRLabel65Print(sender: TObject;
  var Value: String);
begin

  If Trim(strInstr4) <> '' Then
    Value := strInstr4;

end;

procedure TfrmQckBancoBrasil.QRLabel67Print(sender: TObject;
  var Value: String);
begin
  Value := strLinDig;
end;

procedure TfrmQckBancoBrasil.QRLabel68Print(sender: TObject;
  var Value: String);
begin
  Value := strCodBar;
end;

procedure TfrmQckBancoBrasil.QRLabel83Print(sender: TObject;
  var Value: String);
begin
  If fltVlrMor > 0 Then
    Value := 'MORA DIARIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor) + '        ';

  If fltVlrMul > 0 Then
    Value := Trim(Value  + 'APÓS O VENCIMENTO COBRAR MULTA DE ' + FormatFloat('R$ #,##0.00', fltVlrMul));
end;

procedure TfrmQckBancoBrasil.QRLabel84Print(sender: TObject;
  var Value: String);
  Var
    intProtesto : Integer;
begin

  Try
    intProtesto := StrToInt(strPraPro);
  Except
    intProtesto := 0;
  End;

  If intProtesto >= 1 Then
    Value := 'PROTESTAR NO ' + strPraPro + '° DIA ' + IIF(strTipDia='1','ÚTIL', 'CORRIDO') + ' APÓS O VENCIMENTO';
  
end;

procedure TfrmQckBancoBrasil.QRLabel90Print(sender: TObject; var Value: string);
begin
  Value := strEndere;
end;

procedure TfrmQckBancoBrasil.QRLabel70Print(sender: TObject;
  var Value: String);
begin
  Value := strCedent;
end;

procedure TfrmQckBancoBrasil.QRLabel71Print(sender: TObject;
  var Value: String);
begin

  Value := strNossoNu;

end;

procedure TfrmQckBancoBrasil.QRLabel66Print(sender: TObject;
  var Value: String);
begin

  Value := strNossoNu;

end;

procedure TfrmQckBancoBrasil.QRLabel78Print(sender: TObject;
  var Value: String);
begin

  Value := strNossoNu;

end;

procedure TfrmQckBancoBrasil.InsSacPrint(sender: TObject;
  var Value: String);
begin

  If (strNuInSa <> '') Then
  Begin

    If (Length(Trim(strNuInSa)) > 11) Then
      Value := fMaskCNPJ(strNuInSa)
    Else
      Value := fMaskCPF(strNuInSa);

  End;

end;

procedure TfrmQckBancoBrasil.QRLabel6Print(sender: TObject;
  var Value: String);
begin
  Value := RightStr(strCodCar, 2) + '/' + strVariac;
end;

procedure TfrmQckBancoBrasil.QRLabel48Print(sender: TObject;
  var Value: String);
begin
  Value := RightStr(strCodCar, 2) + '/' + strVariac;
end;

procedure TfrmQckBancoBrasil.qrlLinDigPrint(sender: TObject;
  var Value: String);
begin
  Value := strLinDig;
end;

procedure TfrmQckBancoBrasil.FormCreate(Sender: TObject);
begin

  If Not( blnPegImp ) Then
    QckBoleto.Print
  Else
    QckBoleto.Preview;

end;

procedure TfrmQckBancoBrasil.QckBoletoBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
  If Not( blnProEnt ) Then
    qrBandaComprovante.Height := 0
  Else
    qrBandaComprovante.Height := 140;
end;

end.
