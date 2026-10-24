unit untQckBancoPadrao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RLReport, ImgList, RLBarcode, ExtCtrls, StdCtrls, Buttons,
  StrUtils, jpeg, RLFilters, RLPDFFilter, RLPreviewForm;

type
  TfrmQckBancoPadrao = class(TForm)
    qckBoleto: TRLReport;
    RLBand1: TRLBand;
    rlpBandaB: TRLPanel;
    RLPanel2: TRLPanel;
    rlpLogotipo: TRLPanel;
    rlmLogotiB: TRLImage;
    RLPanel3: TRLPanel;
    rllBanDigB: TRLLabel;
    RLPanel4: TRLPanel;
    RLPanel5: TRLPanel;
    RLPanel6: TRLPanel;
    RLLabel3: TRLLabel;
    RLPanel13: TRLPanel;
    RLLabel4: TRLLabel;
    RLPanel7: TRLPanel;
    RLPanel14: TRLPanel;
    RLLabel5: TRLLabel;
    RLPanel15: TRLPanel;
    RLLabel6: TRLLabel;
    RLPanel8: TRLPanel;
    RLPanel16: TRLPanel;
    RLLabel7: TRLLabel;
    RLPanel17: TRLPanel;
    RLLabel8: TRLLabel;
    RLPanel18: TRLPanel;
    RLLabel9: TRLLabel;
    RLPanel19: TRLPanel;
    RLLabel10: TRLLabel;
    RLPanel20: TRLPanel;
    RLLabel11: TRLLabel;
    RLPanel21: TRLPanel;
    RLLabel12: TRLLabel;
    RLPanel9: TRLPanel;
    RLPanel22: TRLPanel;
    RLLabel13: TRLLabel;
    RLPanel23: TRLPanel;
    RLLabel14: TRLLabel;
    RLPanel24: TRLPanel;
    RLLabel15: TRLLabel;
    RLPanel25: TRLPanel;
    RLLabel16: TRLLabel;
    RLPanel26: TRLPanel;
    RLLabel17: TRLLabel;
    RLPanel27: TRLPanel;
    RLLabel18: TRLLabel;
    RLPanel10: TRLPanel;
    RLPanel28: TRLPanel;
    RLLabel19: TRLLabel;
    RLPanel29: TRLPanel;
    RLLabel20: TRLLabel;
    RLPanel11: TRLPanel;
    RLPanel30: TRLPanel;
    RLPanel31: TRLPanel;
    RLLabel22: TRLLabel;
    RLPanel12: TRLPanel;
    RLPanel35: TRLPanel;
    RLPanel36: TRLPanel;
    RLLabel21: TRLLabel;
    RLPanel32: TRLPanel;
    RLPanel37: TRLPanel;
    RLLabel23: TRLLabel;
    RLPanel38: TRLPanel;
    RLPanel33: TRLPanel;
    RLPanel39: TRLPanel;
    RLPanel40: TRLPanel;
    RLLabel24: TRLLabel;
    RLPanel34: TRLPanel;
    RLPanel41: TRLPanel;
    RLLabel25: TRLLabel;
    rllNomSacB: TRLLabel;
    rllEndSacB: TRLLabel;
    rllCepCidB: TRLLabel;
    rllSacadorB: TRLLabel;
    rllInsSacB: TRLLabel;
    rllCodBaiB: TRLLabel;
    RLLabel32: TRLLabel;
    rlpBandaC: TRLPanel;
    RLPanel43: TRLPanel;
    RLPanel44: TRLPanel;
    rlmLogotiC: TRLImage;
    RLPanel45: TRLPanel;
    rllBanDigC: TRLLabel;
    RLPanel46: TRLPanel;
    RLPanel47: TRLPanel;
    RLPanel48: TRLPanel;
    RLLabel34: TRLLabel;
    RLPanel49: TRLPanel;
    RLLabel35: TRLLabel;
    RLPanel50: TRLPanel;
    RLPanel51: TRLPanel;
    RLLabel36: TRLLabel;
    RLPanel52: TRLPanel;
    RLLabel37: TRLLabel;
    RLPanel53: TRLPanel;
    RLPanel54: TRLPanel;
    RLLabel38: TRLLabel;
    RLPanel55: TRLPanel;
    RLLabel39: TRLLabel;
    RLPanel56: TRLPanel;
    RLLabel40: TRLLabel;
    RLPanel57: TRLPanel;
    RLLabel41: TRLLabel;
    RLPanel58: TRLPanel;
    RLLabel42: TRLLabel;
    RLPanel59: TRLPanel;
    RLLabel43: TRLLabel;
    RLPanel60: TRLPanel;
    RLPanel61: TRLPanel;
    RLLabel44: TRLLabel;
    RLPanel62: TRLPanel;
    RLLabel45: TRLLabel;
    RLPanel63: TRLPanel;
    RLLabel46: TRLLabel;
    RLPanel64: TRLPanel;
    RLLabel47: TRLLabel;
    RLPanel65: TRLPanel;
    RLLabel48: TRLLabel;
    RLPanel66: TRLPanel;
    RLLabel49: TRLLabel;
    RLPanel67: TRLPanel;
    RLPanel68: TRLPanel;
    RLLabel50: TRLLabel;
    RLPanel69: TRLPanel;
    RLLabel51: TRLLabel;
    RLPanel70: TRLPanel;
    RLPanel71: TRLPanel;
    RLPanel72: TRLPanel;
    RLLabel52: TRLLabel;
    RLPanel73: TRLPanel;
    RLPanel74: TRLPanel;
    RLPanel75: TRLPanel;
    RLLabel53: TRLLabel;
    RLPanel76: TRLPanel;
    RLPanel77: TRLPanel;
    RLLabel54: TRLLabel;
    RLPanel78: TRLPanel;
    RLPanel79: TRLPanel;
    RLPanel80: TRLPanel;
    RLPanel81: TRLPanel;
    RLLabel55: TRLLabel;
    RLPanel82: TRLPanel;
    RLPanel83: TRLPanel;
    RLLabel56: TRLLabel;
    rllNomSacC: TRLLabel;
    rllEndSacC: TRLLabel;
    rllCepCidC: TRLLabel;
    rllSacadorC: TRLLabel;
    rllInsSacC: TRLLabel;
    rllCodBaiC: TRLLabel;
    RLLabel63: TRLLabel;
    RLLabel33: TRLLabel;
    pnlCortaB: TRLPanel;
    rlpBandaD: TRLPanel;
    RLPanel86: TRLPanel;
    RLPanel87: TRLPanel;
    rlmLogotiD: TRLImage;
    RLPanel88: TRLPanel;
    rllBanDigD: TRLLabel;
    RLPanel89: TRLPanel;
    rllLinDig: TRLLabel;
    RLPanel90: TRLPanel;
    RLPanel91: TRLPanel;
    RLLabel67: TRLLabel;
    RLPanel92: TRLPanel;
    RLLabel68: TRLLabel;
    RLPanel93: TRLPanel;
    RLPanel94: TRLPanel;
    RLLabel69: TRLLabel;
    RLPanel95: TRLPanel;
    RLLabel70: TRLLabel;
    RLPanel96: TRLPanel;
    RLPanel97: TRLPanel;
    RLLabel71: TRLLabel;
    RLPanel98: TRLPanel;
    RLLabel72: TRLLabel;
    RLPanel99: TRLPanel;
    RLLabel73: TRLLabel;
    RLPanel100: TRLPanel;
    RLLabel74: TRLLabel;
    RLPanel101: TRLPanel;
    RLLabel75: TRLLabel;
    RLPanel102: TRLPanel;
    RLLabel76: TRLLabel;
    RLPanel103: TRLPanel;
    RLPanel104: TRLPanel;
    RLLabel77: TRLLabel;
    RLPanel105: TRLPanel;
    RLLabel78: TRLLabel;
    RLPanel106: TRLPanel;
    RLLabel79: TRLLabel;
    RLPanel107: TRLPanel;
    RLLabel80: TRLLabel;
    RLPanel108: TRLPanel;
    RLLabel81: TRLLabel;
    RLPanel109: TRLPanel;
    RLLabel82: TRLLabel;
    RLPanel110: TRLPanel;
    RLPanel111: TRLPanel;
    RLLabel83: TRLLabel;
    RLPanel112: TRLPanel;
    RLLabel84: TRLLabel;
    RLPanel113: TRLPanel;
    RLPanel114: TRLPanel;
    RLPanel115: TRLPanel;
    RLLabel85: TRLLabel;
    RLPanel116: TRLPanel;
    RLPanel117: TRLPanel;
    RLPanel118: TRLPanel;
    RLLabel86: TRLLabel;
    RLPanel119: TRLPanel;
    RLPanel120: TRLPanel;
    RLLabel87: TRLLabel;
    RLPanel121: TRLPanel;
    RLPanel122: TRLPanel;
    RLPanel123: TRLPanel;
    RLPanel124: TRLPanel;
    RLLabel88: TRLLabel;
    RLPanel125: TRLPanel;
    RLPanel126: TRLPanel;
    RLLabel89: TRLLabel;
    rllNomSacD: TRLLabel;
    rllEndSacD: TRLLabel;
    rllCepCidD: TRLLabel;
    rllSacadorD: TRLLabel;
    rllInsSacD: TRLLabel;
    rllCodBaiD: TRLLabel;
    RLLabel96: TRLLabel;
    RLLabel97: TRLLabel;
    rllCodBar: TRLBarcode;
    RLLabel30: TRLLabel;
    rlpBandaA: TRLPanel;
    RLPanel127: TRLPanel;
    RLPanel128: TRLPanel;
    rlmLogotiA: TRLImage;
    RLPanel129: TRLPanel;
    rllBanDigA: TRLLabel;
    RLPanel130: TRLPanel;
    RLLabel98: TRLLabel;
    pnlCortaC: TRLPanel;
    RLPanel133: TRLPanel;
    RLLabel101: TRLLabel;
    RLPanel132: TRLPanel;
    RLLabel100: TRLLabel;
    RLPanel135: TRLPanel;
    RLLabel99: TRLLabel;
    RLPanel137: TRLPanel;
    RLLabel104: TRLLabel;
    RLPanel131: TRLPanel;
    RLLabel102: TRLLabel;
    RLPanel136: TRLPanel;
    RLLabel103: TRLLabel;
    RLPanel138: TRLPanel;
    RLLabel105: TRLLabel;
    RLPanel139: TRLPanel;
    RLLabel106: TRLLabel;
    RLPanel140: TRLPanel;
    RLLabel107: TRLLabel;
    RLPanel141: TRLPanel;
    RLLabel108: TRLLabel;
    RLPanel142: TRLPanel;
    RLLabel109: TRLLabel;
    RLPanel143: TRLPanel;
    RLLabel110: TRLLabel;
    RLLabel111: TRLLabel;
    RLLabel112: TRLLabel;
    RLPanel144: TRLPanel;
    RLPanel145: TRLPanel;
    RLLabel113: TRLLabel;
    RLPanel146: TRLPanel;
    RLLabel114: TRLLabel;
    RLPanel149: TRLPanel;
    RLLabel117: TRLLabel;
    RLPanel150: TRLPanel;
    RLLabel118: TRLLabel;
    RLPanel151: TRLPanel;
    RLLabel119: TRLLabel;
    RLPanel152: TRLPanel;
    RLLabel120: TRLLabel;
    RLPanel147: TRLPanel;
    RLLabel115: TRLLabel;
    RLLabel116: TRLLabel;
    RLPanel148: TRLPanel;
    RLLabel121: TRLLabel;
    RLPanel153: TRLPanel;
    RLLabel122: TRLLabel;
    pnlCortaA: TRLPanel;
    RLPanel154: TRLPanel;
    RLPanel155: TRLPanel;
    pnlLogos: TPanel;
    imgBancoReal: TImage;
    rllNomCedB: TRLLabel;
    rllLocPagB: TRLLabel;
    rllNomCedA: TRLLabel;
    rllNomSacA: TRLLabel;
    rllAgeCedA: TRLLabel;
    rllNosNumA: TRLLabel;
    rllValDocA: TRLLabel;
    rllNumDocA: TRLLabel;
    rllVencimA: TRLLabel;
    rllEspMoeA: TRLLabel;
    rllVencimB: TRLLabel;
    rllAgeCedB: TRLLabel;
    rllNosNumB: TRLLabel;
    rllValDocB: TRLLabel;
    rllValMoeB: TRLLabel;
    rllQuantiB: TRLLabel;
    rllEspMoeB: TRLLabel;
    rllCarteiB: TRLLabel;
    rllUsoBanB: TRLLabel;
    rllInstru1B: TRLLabel;
    rllInstru2B: TRLLabel;
    rllInstru3B: TRLLabel;
    rllInstru4B: TRLLabel;
    rllInstru5B: TRLLabel;
    rllInstru6B: TRLLabel;
    rllInstru7B: TRLLabel;
    rllInstru8B: TRLLabel;
    rllInstru9B: TRLLabel;
    rllInstru10B: TRLLabel;
    rllLocPagC: TRLLabel;
    rllNomCedC: TRLLabel;
    rllVencimC: TRLLabel;
    rllAgeCedC: TRLLabel;
    rllNosNumC: TRLLabel;
    rllValDocC: TRLLabel;
    rllCarteiC: TRLLabel;
    rllEspMoeC: TRLLabel;
    rllQuantiC: TRLLabel;
    rllValMoeC: TRLLabel;
    rllDtaDocB: TRLLabel;
    rllNumDocB: TRLLabel;
    rllEspDocB: TRLLabel;
    rllAceiteB: TRLLabel;
    rllDtaProB: TRLLabel;
    rllUsoBanC: TRLLabel;
    rllDtaDocC: TRLLabel;
    rllNumDocC: TRLLabel;
    rllEspDocC: TRLLabel;
    rllAceiteC: TRLLabel;
    rllDtaProC: TRLLabel;
    rllLocPagD: TRLLabel;
    rllNomCedD: TRLLabel;
    rllDtaDocD: TRLLabel;
    rllNumDocD: TRLLabel;
    rllEspDocD: TRLLabel;
    rllAceiteD: TRLLabel;
    rllDtaProD: TRLLabel;
    rllUsoBanD: TRLLabel;
    rllCarteiD: TRLLabel;
    rllEspMoeD: TRLLabel;
    rllQuantiD: TRLLabel;
    rllValMoeD: TRLLabel;
    rllVencimD: TRLLabel;
    rllAgeCedD: TRLLabel;
    rllNosNumD: TRLLabel;
    rllValDocD: TRLLabel;
    rllInstru1C: TRLLabel;
    rllInstru2C: TRLLabel;
    rllInstru1D: TRLLabel;
    rllInstru2D: TRLLabel;
    rllInstru3C: TRLLabel;
    rllInstru4C: TRLLabel;
    rllInstru5C: TRLLabel;
    rllInstru6C: TRLLabel;
    rllInstru7C: TRLLabel;
    rllInstru8C: TRLLabel;
    rllInstru9C: TRLLabel;
    rllInstru10C: TRLLabel;
    rllInstru3D: TRLLabel;
    rllInstru4D: TRLLabel;
    rllInstru5D: TRLLabel;
    rllInstru6D: TRLLabel;
    rllInstru7D: TRLLabel;
    rllInstru8D: TRLLabel;
    rllInstru9D: TRLLabel;
    rllInstru10D: TRLLabel;
    RLLabel26: TRLLabel;
    RLLabel27: TRLLabel;
    RLLabel28: TRLLabel;
    RLLabel29: TRLLabel;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    imgBancoHSBC: TImage;
    imgBanrisul: TImage;
    RLPDFFilter: TRLPDFFilter;
    rpsSetup: TRLPreviewSetup;
    procedure qckBoletoBeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
    function fIniciaQckBoleto(strCodBan: String): Boolean;

  public
    { Public declarations }

    class var strNomFrm: String;
    class var strNomImp: String;

  end;

var
  frmQckBancoPadrao: TfrmQckBancoPadrao;

implementation

uses untFuncoesBoleto, untFuncoesSimples;

{$R *.dfm}

procedure TfrmQckBancoPadrao.qckBoletoBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin

  fIniciaQckBoleto(strIdeBan);

end;

function TfrmQckBancoPadrao.fIniciaQckBoleto(strCodBan: String): Boolean;
begin

  //*************************************************//
  // DADOS DO SACADO                                 //
  //**********************************************ED*//
  Result := false;

  rllNomSacA.Caption := strNomSac;
  rllNomSacB.Caption := rllNomSacA.Caption;
  rllNomSacC.Caption := rllNomSacB.Caption;
  rllNomSacD.Caption := rllNomSacB.Caption;

  rllEndSacB.Caption := strEndSac;
  rllEndSacC.Caption := rllEndSacB.Caption;
  rllEndSacD.Caption := rllEndSacB.Caption;

  rllCepCidB.Caption := strCep001 + ' - ' + strCidSac + '/' +  strEstSac;
  rllCepCidC.Caption := rllCepCidB.Caption;
  rllCepCidD.Caption := rllCepCidB.Caption;


  If Length(Trim(strNuInSa)) > 11 Then
    rllInsSacB.Caption := fMaskCNPJ(strNuInSa)
  Else
    rllInsSacB.Caption := fMaskCPF(strNuInSa);

  rllInsSacC.Caption := rllInsSacB.Caption;
  rllInsSacD.Caption := rllInsSacB.Caption;


  //*************************************************//
  // CEDENTE / SACADOR / AVALISTA                    //
  //**********************************************ED*//
  rllNomCedA.Caption := strNomCed;
  rllNomCedB.Caption := rllNomCedA.Caption;
  rllNomCedC.Caption := rllNomCedA.Caption;
  rllNomCedD.Caption := rllNomCedA.Caption;

  If Pos(strCodBan,'399_') <= 0 Then
  Begin
    rllSacadorB.Caption := 'Sacador/Avalista: ' + strSacAva;
    rllSacadorC.Caption := rllSacadorB.Caption;
    rllSacadorD.Caption := rllSacadorB.Caption;
  End;

  rllLocPagB.Caption := strLocPag;
  rllLocPagC.Caption := rllLocPagB.Caption;
  rllLocPagD.Caption := rllLocPagB.Caption;


  //*************************************************//
  // DATAS, TIPO DE DOCUMENTO                        //
  //**********************************************ED*//
  rllVencimA.Caption := FormatDateTime('dd/mm/yyyy', dtaDtaVen);
  rllVencimB.Caption := rllVencimA.Caption;
  rllVencimC.Caption := rllVencimA.Caption;
  rllVencimD.Caption := rllVencimA.Caption;

  rllDtaProB.Caption := FormatDateTime('dd/mm/yyyy', dtaDtaPro);
  rllDtaProC.Caption := rllDtaProB.Caption;
  rllDtaProD.Caption := rllDtaProB.Caption;

  rllDtaDocB.Caption := FormatDateTime('dd/mm/yyyy', dtaDtaEmi);
  rllDtaDocC.Caption := rllDtaDocB.Caption;
  rllDtaDocD.Caption := rllDtaDocB.Caption;

  rllCarteiB.Caption := strCodCar;
  rllCarteiC.Caption := rllCarteiB.Caption;
  rllCarteiD.Caption := rllCarteiB.Caption;

  rllEspDocB.Caption := strEspDoc;
  rllEspDocC.Caption := rllEspDocB.Caption;
  rllEspDocD.Caption := rllEspDocB.Caption;

  rllEspMoeA.Caption := 'R$';
  rllEspMoeB.Caption := rllEspMoeA.Caption;
  rllEspMoeC.Caption := rllEspMoeA.Caption;
  rllEspMoeD.Caption := rllEspMoeA.Caption;

  rllNumDocA.Caption := strNumDoc;
  rllNumDocB.Caption := rllNumDocA.Caption;
  rllNumDocC.Caption := rllNumDocA.Caption;
  rllNumDocD.Caption := rllNumDocA.Caption;

  rllValMoeB.Caption := '';
  rllValMoeC.Caption := rllValMoeB.Caption;
  rllValMoeD.Caption := rllValMoeB.Caption;

  rllLinDig.Caption  := strLinDig;
  rllCodBar.Caption  := strCodBar;

  rllValDocA.Caption := FormatFloat('R$ #,##0.00',fStrToFloat(strVlrTit)/100);
  rllValDocB.Caption := rllValDocA.Caption;
  rllValDocC.Caption := rllValDocA.Caption;
  rllValDocD.Caption := rllValDocA.Caption;

  rllAceiteB.Caption := 'Não';
  rllAceiteC.Caption := rllAceiteB.Caption;
  rllAceiteD.Caption := rllAceiteB.Caption;

  {***************************************************}
  {* VARIAVEL DE USO DO BANCO                        *}
  {************************************************LB*}
  If Not (strUsoBan = '') Then
    rllUsoBanB.Caption := strUsoBan
  Else
    rllUsoBanB.Caption := '';

  rllUsoBanC.Caption := rllUsoBanB.Caption;
  rllUsoBanD.Caption := rllUsoBanB.Caption;


  //*************************************************//
  // INSTRUCOES SOBRE O RECEBIMENTO (MORA DIARIA)    //
  //**********************************************ED*//
  If fltVlrMor > 0 Then
  Begin
    rllInstru1B.Caption := 'MORA DIARIA DE ' + FormatFloat('R$ #,##0.00', fltVlrMor);
    rllInstru2B.Caption := 'NAO RECEBER O PRINCIPAL SEM JUROS DE MORA';
  End;


  //*************************************************//
  // INSTRUCOES SOBRE O RECEBIMENTO (PROTESTO)       //
  //**********************************************ED*//
  Try

    If StrToInt(strPraPro) = 1 Then
      rllInstru3B.Caption  := 'PROTESTAR APOS ' + strPraPro + ' DIA DO VENCIMENTO'
    Else If StrToInt(strPraPro) > 1 Then
      rllInstru3B.Caption  := 'PROTESTAR APOS ' + strPraPro + ' DIAS DO VENCIMENTO'
    Else
      rllInstru3B.Caption  := ' ';

  Except
    rllInstru3B.Caption  := ' ';
  End;


  rllInstru4B.Caption  := strInstr1;
  rllInstru5B.Caption  := strInstr2;
  rllInstru6B.Caption  := strInstr3;
  rllInstru7B.Caption  := strInstr4;
  rllInstru8B.Caption  := strInstr5;
  rllInstru9B.Caption  := ''; // DISPONIVEL PARA NOVAS MENSAGENS
  rllInstru10B.Caption := ''; // DISPONIVEL PARA NOVAS MENSAGENS

  rllInstru1C.Caption  := rllInstru1B.Caption;
  rllInstru2C.Caption  := rllInstru2B.Caption;
  rllInstru3C.Caption  := rllInstru3B.Caption;
  rllInstru4C.Caption  := rllInstru4B.Caption;
  rllInstru5C.Caption  := rllInstru5B.Caption;
  rllInstru6C.Caption  := rllInstru6B.Caption;
  rllInstru7C.Caption  := rllInstru7B.Caption;
  rllInstru8C.Caption  := rllInstru8B.Caption;
  rllInstru9C.Caption  := rllInstru9B.Caption;
  rllInstru10C.Caption := rllInstru10B.Caption;

  rllInstru1D.Caption  := rllInstru1B.Caption;
  rllInstru2D.Caption  := rllInstru2B.Caption;
  rllInstru3D.Caption  := rllInstru3B.Caption;
  rllInstru4D.Caption  := rllInstru4B.Caption;
  rllInstru5D.Caption  := rllInstru5B.Caption;
  rllInstru6D.Caption  := rllInstru6B.Caption;
  rllInstru7D.Caption  := rllInstru7B.Caption;
  rllInstru8D.Caption  := rllInstru8B.Caption;
  rllInstru9D.Caption  := rllInstru9B.Caption;
  rllInstru10D.Caption := rllInstru10B.Caption;


  //*************************************************//
  // CARREGA O LOGOTIPO DO BANCOS E CONFIGURA AS     //
  // SUAS PARTICULARIDADES                           //
  //**********************************************ED*//
  If strCodBan = '041' Then
  Begin

    {LOGOTIPO}
    rlmLogotiA.Picture := imgBanrisul.Picture;
    rlmLogotiB.Picture := rlmLogotiA.Picture;
    rlmLogotiC.Picture := rlmLogotiA.Picture;
    rlmLogotiD.Picture := rlmLogotiA.Picture;

    //**************************************************//
    // AGENCIA / COD. CEDENTE / NOSSO NUMERO / CARTEIRA //
    //***********************************************ED*//
    rllAgeCedA.Caption := strNumAge + '.' + strDigAge + ' ' + LeftStr(strCodCed, 6) + '.' + Copy(LeftStr(strCodCed, 7),7,1) + '.' + RightStr(strCodCed, 2);//strNumAge + strDigAge + ' ' + LeftStr(strCodCed, 7) + '.' + RightStr(strCodCed, 2);
    rllAgeCedB.Caption := rllAgeCedA.Caption;
    rllAgeCedC.Caption := rllAgeCedA.Caption;
    rllAgeCedD.Caption := rllAgeCedA.Caption;

    rllNosNumA.Caption :=  LeftStr(strNosNum, 8) + '.' + RightStr(strNosNum, 2);
    rllNosNumB.Caption := rllNosNumA.Caption;
    rllNosNumC.Caption := rllNosNumA.Caption;
    rllNosNumD.Caption := rllNosNumA.Caption;

    rllCodBaiB.Caption := rllNosNumA.Caption;
    rllCodBaiC.Caption := rllCodBaiB.Caption;
    rllCodBaiD.Caption := rllCodBaiB.Caption;

    rllBanDigA.Caption := '041-8';
    rllBanDigB.Caption := rllBanDigA.Caption;
    rllBanDigC.Caption := rllBanDigA.Caption;
    rllBanDigD.Caption := rllBanDigA.Caption;

    rllLocPagB.Caption := 'PAGÁVEL EM QUALQUER BANCO.';
    rllLocPagC.Caption := rllLocPagB.Caption;
    rllLocPagD.Caption := rllLocPagB.Caption;

  End

  //*************************************************//
  // CARREGA O LOGOTIPO DO BANCOS E CONFIGURA AS     //
  // SUAS PARTICULARIDADES                           //
  //**********************************************ED*//
  Else If strCodBan = '356' Then
  Begin

    {LOGOTIPO}
    rlmLogotiA.Picture := imgBancoReal.Picture;
    rlmLogotiB.Picture := rlmLogotiA.Picture;
    rlmLogotiC.Picture := rlmLogotiA.Picture;
    rlmLogotiD.Picture := rlmLogotiA.Picture;

    //**************************************************//
    // AGENCIA / COD. CEDENTE / NOSSO NUMERO / CARTEIRA //
    //***********************************************ED*//
    rllAgeCedA.Caption := strNumAge + '/' + strCodCed + '/' + strDigita;
    rllAgeCedB.Caption := rllAgeCedA.Caption;
    rllAgeCedC.Caption := rllAgeCedA.Caption;
    rllAgeCedD.Caption := rllAgeCedA.Caption;


    //*************************************************//
    // ESSA ALTERACAO FOI FEITA, POIS SEGUNDO O BANCO  //
    // QUANDO A COBRANCA E PELA CARTEIRA 57, NAO DEVE  //
    // IMPRIMIR O NUMERO DA CARTEIRA JUNTO AO NOSSO    //
    // NUMERO                                          //
    //**********************************************ED*//
    rllNosNumA.Caption := strCodCar + '/' + strNosNum;
    If Pos(strCodCar, '_57_42') >= 1 Then
      rllNosNumA.Caption := strNosNum;


    rllNosNumB.Caption := rllNosNumA.Caption;
    rllNosNumC.Caption := rllNosNumA.Caption;
    rllNosNumD.Caption := rllNosNumA.Caption;

    rllCodBaiB.Caption := rllNosNumA.Caption;
    rllCodBaiC.Caption := rllCodBaiB.Caption;
    rllCodBaiD.Caption := rllCodBaiB.Caption;

    rllBanDigA.Caption := '356-5';
    rllBanDigB.Caption := rllBanDigA.Caption;
    rllBanDigC.Caption := rllBanDigA.Caption;
    rllBanDigD.Caption := rllBanDigA.Caption;

    rllLocPagB.Caption := 'PAGÁVEL EM QUALQUER BANCO.';
    rllLocPagC.Caption := rllLocPagB.Caption;
    rllLocPagD.Caption := rllLocPagB.Caption;

  End

  Else If strCodBan = '399' Then
  Begin

    {LOGOTIPO}
    rlmLogotiA.Picture := imgBancoHSBC.Picture;
    rlmLogotiB.Picture := rlmLogotiA.Picture;
    rlmLogotiC.Picture := rlmLogotiA.Picture;
    rlmLogotiD.Picture := rlmLogotiA.Picture;

    //**************************************************//
    // AGENCIA / COD. CEDENTE / NOSSO NUMERO / CARTEIRA //
    //***********************************************ED*//
    If strModCob = 'S' Then
      rllAgeCedA.Caption := strNumAge + ' ' + LeftStr(strCodCed, 7)
    Else
      rllAgeCedA.Caption := LeftStr(strCodCed, 7);

    rllAgeCedB.Caption := rllAgeCedA.Caption;
    rllAgeCedC.Caption := rllAgeCedA.Caption;
    rllAgeCedD.Caption := rllAgeCedA.Caption;

    If strModCob = 'S' Then
      rllNosNumA.Caption := LeftStr(strNosNum, 10) + '.' + RightStr(strNosNum, 1)
    Else
      rllNosNumA.Caption := fStrZero(LeftStr(strNosNum, 10),13) + '.' + RightStr(strNosNum, 3);

    rllNosNumB.Caption := rllNosNumA.Caption;
    rllNosNumC.Caption := rllNosNumA.Caption;
    rllNosNumD.Caption := rllNosNumA.Caption;

    rllCodBaiB.Caption := rllNosNumA.Caption;
    rllCodBaiC.Caption := rllCodBaiB.Caption;
    rllCodBaiD.Caption := rllCodBaiB.Caption;

    rllBanDigA.Caption := '399-9';
    rllBanDigB.Caption := rllBanDigA.Caption;
    rllBanDigC.Caption := rllBanDigA.Caption;
    rllBanDigD.Caption := rllBanDigA.Caption;

    rllLocPagB.Caption := 'PAGÁVEL EM QUALQUER BANCO.';
    rllLocPagC.Caption := rllLocPagB.Caption;
    rllLocPagD.Caption := rllLocPagB.Caption;

    If strModCob = 'S' Then
      rllCarteiB.Caption := 'COB'
    Else
      rllCarteiB.Caption := 'CNR';

    rllCarteiC.Caption := rllCarteiB.Caption;
    rllCarteiD.Caption := rllCarteiC.Caption

  End;



  //*************************************************//
  // VALIDA SE QUAIS AS BANDAS SERAO IMPRESSAS       //
  //  ->PROTOCOLO                                    //
  //  ->FICHA DE CAIXA                               //
  //  ->RECIBO DO SACADO                             //
  //  ->FICHA DE COMPENSACAO                         //
  //                                                 //
  //**********************************************ED*//
  If Not( blnProEnt ) Then
  Begin
    rlpBandaA.Visible := False;
    pnlCortaA.Visible := False;
    rlpBandaB.Align   := faTop;
    pnlCortaB.Align   := faTop;
    pnlCortaB.Height  := 62;
    rlpBandaC.Align   := faTop;
  End;

end;

procedure TfrmQckBancoPadrao.FormCreate(Sender: TObject);
begin

  If blnBolPdf Then
  Begin

    RLPDFFilter.FileName := ExtractFilePath(Application.ExeName) + '\Boletos\' + strNumDoc + '.PDF';
    QckBoleto.SaveToFile(ExtractFilePath(Application.ExeName) + '\Boletos\' + strNumDoc + '.PDF');

  End
  Else
  Begin
    If Not( blnPegImp ) Then
      pPrintReport(strNomFrm, 'Impressão de Boleto(s) - (Banco ' + strIdeBan + ')', strNomImp, QckBoleto)
    Else
      pPreviewReport(strNomFrm, 'Impressão de Boleto(s) - (Banco ' + strIdeBan + ')', QckBoleto, rpsSetup);
  End;

end;

end.
