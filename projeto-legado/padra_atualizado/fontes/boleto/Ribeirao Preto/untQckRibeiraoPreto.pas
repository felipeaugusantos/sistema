unit untQckRibeiraoPreto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, ExtCtrls, RLReport, StrUtils, QRExport,
  MaskUtils;

type
  TfrmQckRibeiraoPreto = class(TForm)
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
    LabelAutenticacaoMecanica: TQRLabel;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    LabelNomeTitular: TQRLabel;
    QRShape1: TQRShape;
    LabelInformacao1: TQRLabel;
    QRLabel2: TQRLabel;
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
    QRLabel3: TQRLabel;
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
    QRLabel34: TQRLabel;
    QRShape23: TQRShape;
    QRShape24: TQRShape;
    QRLabel35: TQRLabel;
    QRLabel36: TQRLabel;
    QRLabel37: TQRLabel;
    QRShape26: TQRShape;
    QRLabel41: TQRLabel;
    QRLabel43: TQRLabel;
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
    QRLabel79: TQRLabel;
    QRLabel80: TQRLabel;
    QRLabel81: TQRLabel;
    QRLabel82: TQRLabel;
    QRLabel83: TQRLabel;
    QRLabel84: TQRLabel;
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
    QRShape38: TQRShape;
    QRShape39: TQRShape;
    QRShape40: TQRShape;
    QRShape41: TQRShape;
    QRShape42: TQRShape;
    QRShape43: TQRShape;
    QRShape44: TQRShape;
    QRShape45: TQRShape;
    QRShape46: TQRShape;
    QRLabel89: TQRLabel;
    QRLabel90: TQRLabel;
    QRShape47: TQRShape;
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
    QRShape48: TQRShape;
    QRShape49: TQRShape;
    QRLabel113: TQRLabel;
    QRShape50: TQRShape;
    QRLabel116: TQRLabel;
    QRLabel117: TQRLabel;
    QRShape51: TQRShape;
    QRShape52: TQRShape;
    QRShape53: TQRShape;
    QRShape54: TQRShape;
    QRShape55: TQRShape;
    QRShape56: TQRShape;
    QRShape57: TQRShape;
    QRShape58: TQRShape;
    QRLabel118: TQRLabel;
    QRShape59: TQRShape;
    QRLabel119: TQRLabel;
    QRShape60: TQRShape;
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
    QRLabel133: TQRLabel;
    QRLabel135: TQRLabel;
    QRLabel136: TQRLabel;
    QRLabel137: TQRLabel;
    QRLabel138: TQRLabel;
    QRLabel139: TQRLabel;
    QRLabel140: TQRLabel;
    QRLabel141: TQRLabel;
    QRLabel142: TQRLabel;
    QRLabel67: TQRLabel;
    QRLabel132: TQRLabel;
    QRLabel38: TQRLabel;
    QRLabel143: TQRLabel;
    QRLabel144: TQRLabel;
    QRLabel145: TQRLabel;
    QRShape28: TQRShape;
    QRLabel10: TQRLabel;
    QRImage4: TQRImage;
    QRImage1: TQRImage;
    QRShape61: TQRShape;
    QRLabel146: TQRLabel;
    QRShape62: TQRShape;
    QRImage3: TQRImage;
    QRShape63: TQRShape;
    QRShape64: TQRShape;
    QRLabel147: TQRLabel;
    QRLabel148: TQRLabel;
    QRLabel149: TQRLabel;
    QRLabel150: TQRLabel;
    QRShape65: TQRShape;
    QRShape66: TQRShape;
    QRLabel151: TQRLabel;
    QRLabel152: TQRLabel;
    QRShape67: TQRShape;
    QRLabel153: TQRLabel;
    QRLabel154: TQRLabel;
    QRLabel155: TQRLabel;
    QRLabel156: TQRLabel;
    QRShape68: TQRShape;
    QRLabel157: TQRLabel;
    QRLabel158: TQRLabel;
    QRShape69: TQRShape;
    QRShape70: TQRShape;
    QRLabel159: TQRLabel;
    QRLabel160: TQRLabel;
    QRLabel161: TQRLabel;
    QRLabel162: TQRLabel;
    QRLabel163: TQRLabel;
    QRLabel164: TQRLabel;
    QRLabel165: TQRLabel;
    QRLabel166: TQRLabel;
    QRShape71: TQRShape;
    QRLabel167: TQRLabel;
    QRLabel168: TQRLabel;
    QRShape72: TQRShape;
    QRShape73: TQRShape;
    QRLabel169: TQRLabel;
    QRLabel170: TQRLabel;
    QRShape74: TQRShape;
    QRShape75: TQRShape;
    QRLabel171: TQRLabel;
    QRShape76: TQRShape;
    QRLabel172: TQRLabel;
    QRLabel173: TQRLabel;
    QRShape77: TQRShape;
    QRShape78: TQRShape;
    QRLabel174: TQRLabel;
    QRShape79: TQRShape;
    QRLabel175: TQRLabel;
    QRLabel176: TQRLabel;
    QRShape80: TQRShape;
    QRShape81: TQRShape;
    QRLabel177: TQRLabel;
    QRShape82: TQRShape;
    QRLabel178: TQRLabel;
    QRShape83: TQRShape;
    QRLabel179: TQRLabel;
    QRShape84: TQRShape;
    QRLabel180: TQRLabel;
    QRLabel114: TQRLabel;
    QRLabel66: TQRLabel;
    QRLabel112: TQRLabel;
    QRLabel115: TQRLabel;
    QRLabel131: TQRLabel;
    QRShape85: TQRShape;
    QRShape86: TQRShape;
    QRLabel33: TQRLabel;
    QRLabel78: TQRLabel;
    QRLabel134: TQRLabel;
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
    procedure QRLabel42Print(sender: TObject; var Value: String);
    procedure QRLabel57Print(sender: TObject; var Value: String);
    procedure QRLabel58Print(sender: TObject; var Value: String);
    procedure QRLabel59Print(sender: TObject; var Value: String);
    procedure QRLabel60Print(sender: TObject; var Value: String);
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
    procedure QRLabel73Print(sender: TObject; var Value: String);
    procedure QRLabel33Print(sender: TObject; var Value: String);
    procedure FormCreate(Sender: TObject);
    procedure QRLabel39Print(sender: TObject; var Value: String);
    procedure QRLabel40Print(sender: TObject; var Value: String);
    procedure QRLabel118Print(sender: TObject; var Value: String);
    procedure QRLabel44Print(sender: TObject; var Value: String);
  private
    { Private declarations }
    strAgeDig : String;
    strCaAgNs : String;

  public
    { Public declarations }
  end;

var
  frmQckRibeiraoPreto: TfrmQckRibeiraoPreto;

implementation

uses
   untFuncoesBoleto, untFuncoesSimples;

{$R *.dfm}

procedure TfrmQckRibeiraoPreto.LabelNomeTitularPrint(sender: TObject;
  var Value: String);
begin

  Value := strNomSac;

end;

procedure TfrmQckRibeiraoPreto.LabelEnderecoPrint(sender: TObject;
  var Value: String);
begin

  Value := strEndSac + ' - ' + strBaiSac;

end;

procedure TfrmQckRibeiraoPreto.LabelCidadePrint(sender: TObject;
  var Value: String);
begin

  Value := fMaskCEP(strCep001) + ' - ' + strCidSac + ' - ' + strEstSac

end;

procedure TfrmQckRibeiraoPreto.LabelNomeTitular2Print(sender: TObject;
  var Value: String);
begin

	Value := strNomSac;

end;

procedure TfrmQckRibeiraoPreto.LabelEndereco2Print(sender: TObject;
  var Value: String);
begin

  Value := strEndSac + ' - ' + strBaiSac;

end;

procedure TfrmQckRibeiraoPreto.LabelCidade2Print(sender: TObject;
  var Value: String);
begin

  Value := fMaskCEP(strCep001) + ' ' + strCidSac + ' ' + strEstSac;

end;

procedure TfrmQckRibeiraoPreto.LabelNomeTitular3Print(sender: TObject;
  var Value: String);
begin

	Value := strNomSac;

end;

procedure TfrmQckRibeiraoPreto.LabelEndereco3Print(sender: TObject;
  var Value: String);
begin

  Value := strEndSac + ' - ' + strBaiSac;

end;

procedure TfrmQckRibeiraoPreto.LabelCidade3Print(sender: TObject;
  var Value: String);
begin

  Value := strCep001 + ' ' + strCidSac + ' ' + strEstSac;

end;


procedure TfrmQckRibeiraoPreto.LabelNomeCedentePrint(sender: TObject;
  var Value: String);
begin

  If strTipIns = '01' Then
    Value := strNomCed + '   ' + fMaskCNPJ(strNumIns)
  Else
    Value := strNomCed + '   ' +fMaskCPF(strNumIns);

end;

procedure TfrmQckRibeiraoPreto.QRLabel50Print(sender: TObject;
  var Value: String);
begin
  Value := FormatDateTime('dd/mm/yyyy', dtaDtaVen);

end;

procedure TfrmQckRibeiraoPreto.QRLabel51Print(sender: TObject;
  var Value: String);
begin
  Value := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);

end;

procedure TfrmQckRibeiraoPreto.QRLabel56Print(sender: TObject;
  var Value: String);
begin
  value := strNumDoc;
end;

procedure TfrmQckRibeiraoPreto.QRLabel42Print(sender: TObject;
  var Value: String);
begin
  If strIdeAce = 'A' Then
    Value := 'S'
  Else
    Value := 'N';
end;

procedure TfrmQckRibeiraoPreto.QRLabel57Print(sender: TObject;
  var Value: String);
begin

  Value := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
end;

procedure TfrmQckRibeiraoPreto.QRLabel58Print(sender: TObject;
  var Value: String);
begin

  strAgeDig := strNumAge + strDigAge + strCodCed;

  Insert('-', strAgeDig, 5);
  Insert('/', strAgeDig, 7);
  Insert('-', strAgeDig, 15);

  Value := strAgeDig;

end;

procedure TfrmQckRibeiraoPreto.QRLabel59Print(sender: TObject;
  var Value: String);
begin

  strCaAgNs := strCodCar + strNosNum;

  Insert('/', strCaAgNs, 3);
  Insert('-', strCaAgNs, 15);

  Value := strCaAgNs;

end;

procedure TfrmQckRibeiraoPreto.QRLabel60Print(sender: TObject;
  var Value: String);
begin

  Value := FormatFloat('#,##0.00', fStrToFloat(LeftStr(strVlrTit, 8) + ',' + RightStr(strVlrTit, 2)));

end;

procedure TfrmQckRibeiraoPreto.QRLabel61Print(sender: TObject;
  var Value: String);
begin
   If Trim(strInstr1) <> '' Then
    Value := strInstr1;
end;

procedure TfrmQckRibeiraoPreto.QRLabel62Print(sender: TObject;
  var Value: String);
begin
  If Trim(strInstr2) <> '' Then
    Value := strInstr2;
end;

procedure TfrmQckRibeiraoPreto.QRLabel63Print(sender: TObject;
  var Value: String);
begin

  If Trim(strInstr3) <> '' Then
    Value := strInstr3;

end;

procedure TfrmQckRibeiraoPreto.QRLabel64Print(sender: TObject;
  var Value: String);
begin

  If Trim(strInstr4) <> '' Then
    Value := strInstr4;

end;

procedure TfrmQckRibeiraoPreto.QRLabel65Print(sender: TObject;
  var Value: String);
begin

  If Trim(strInstr5) <> '' Then
    Value := strInstr5;

end;

procedure TfrmQckRibeiraoPreto.QRLabel67Print(sender: TObject;
  var Value: String);
begin
  Value := strLinDig;
end;

procedure TfrmQckRibeiraoPreto.QRLabel68Print(sender: TObject;
  var Value: String);
begin
  Value := strCodBar;
end;

procedure TfrmQckRibeiraoPreto.QRLabel83Print(sender: TObject;
  var Value: String);
begin
  If fltVlrMor > 0 Then
    Value := 'MORA DIARIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor);
end;

procedure TfrmQckRibeiraoPreto.QRLabel84Print(sender: TObject;
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
    Value := 'PROTESTAR APOS ' + strPraPro + ' DIA CORRIDO DO VENCIMENTO';
  End
  Else If intProtesto > 1 Then
  Begin
    Value := 'PROTESTAR APOS ' + strPraPro + ' DIAS CORRIDOS DO VENCIMENTO';
  End;

end;

procedure TfrmQckRibeiraoPreto.QRLabel70Print(sender: TObject;
  var Value: String);
begin
  Value := strAgeDig;
end;

procedure TfrmQckRibeiraoPreto.QRLabel71Print(sender: TObject;
  var Value: String);
begin

  Value := strCaAgNs;

end;

procedure TfrmQckRibeiraoPreto.QRLabel66Print(sender: TObject;
  var Value: String);
begin
  Value := QRLabel59.Caption;

end;

procedure TfrmQckRibeiraoPreto.QRLabel78Print(sender: TObject;
  var Value: String);
begin
  Value := strSacAva;
end;

procedure TfrmQckRibeiraoPreto.InsSacPrint(sender: TObject;
  var Value: String);
begin
{
  If (strNuInSa <> '') Then
  Begin

    If (Length(Trim(strNuInSa)) > 11) Then
      Value := fMaskCNPJ(strNuInSa)
    Else
      Value := fMaskCPF(strNuInSa);

  End;
}
end;

procedure TfrmQckRibeiraoPreto.QRLabel6Print(sender: TObject;
  var Value: String);
begin
  Value := strCodCar;
end;

procedure TfrmQckRibeiraoPreto.QRLabel48Print(sender: TObject;
  var Value: String);
begin
  Value := strCodCar
end;

procedure TfrmQckRibeiraoPreto.QRLabel73Print(sender: TObject;
  var Value: String);
begin
  If fltVlrMor > 0 Then
    Value := 'NAO RECEBER O PRINCIPAL SEM JUROS DE MORA';

end;

procedure TfrmQckRibeiraoPreto.QRLabel33Print(sender: TObject;
  var Value: String);
begin
{
  If (strTipIns <> '') And (strTipIns <> '') Then
  Begin

    If (strTipIns = '01') Then
      Value := strSacAva + ' - ' + fMaskCNPJ(strNumIns)
    Else
      Value := strSacAva + ' - ' + fMaskCPF(strNumIns);

  End;
}

  Value := strSacAva;

end;

procedure TfrmQckRibeiraoPreto.FormCreate(Sender: TObject);
begin

  If Not( blnPegImp ) Then
    QckBoleto.Print
  Else
    QckBoleto.Preview;
  
end;

procedure TfrmQckRibeiraoPreto.QRLabel39Print(sender: TObject;
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

procedure TfrmQckRibeiraoPreto.QRLabel40Print(sender: TObject;
  var Value: String);
begin
  Value := strUsoBan;
end;

procedure TfrmQckRibeiraoPreto.QRLabel118Print(sender: TObject;
  var Value: String);
begin
  Value := strUsoBan;
end;

procedure TfrmQckRibeiraoPreto.QRLabel44Print(sender: TObject;
  var Value: String);
begin
  Value := strUsoBan;
end;

end.
