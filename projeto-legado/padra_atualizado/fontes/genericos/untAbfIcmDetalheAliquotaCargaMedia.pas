unit untAbfIcmDetalheAliquotaCargaMedia;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  Datasnap.DBClient, UniClientDataSet, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxContainer, cxProgressBar, Vcl.ComCtrls, cxCurrencyEdit, cxGridCitel;

type
  TTipoPerfil = (tppfPEF, tppfPEJ, tppfPER, tppfPES, tppfPSI, tppfPII);

  TfrmAbfIcmDetalheAliquotaCargaMedia = class(TfrmPaiConfirma)
    cxGrid1DBTableView1: TcxGridDBTableViewCitel;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGridCitel;
    cdsDados: TUniClientDataSet;
    dtsDados: TDataSource;
    cdsDadosPERFIL: TStringField;
    cdsDadosUNIFED: TStringField;
    cdsDadosALQINT: TFloatField;
    cdsDadosREDEMP: TFloatField;
    cdsDadosCARLIQ: TFloatField;
    cdsDadosALQIVA: TFloatField;
    cdsDadosFORCAL: TStringField;
    cdsDadosBASEST: TFloatField;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    cxGrid1DBTableView1Column3: TcxGridDBColumn;
    cxGrid1DBTableView1Column4: TcxGridDBColumn;
    cxGrid1DBTableView1Column5: TcxGridDBColumn;
    cxGrid1DBTableView1Column6: TcxGridDBColumn;
    cxGrid1DBTableView1Column7: TcxGridDBColumn;
    cxGrid1DBTableView1Column8: TcxGridDBColumn;
    cdsDadosKEY: TStringField;
    cxGrid1DBTableView1Column9: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
  private
    PerfilExterno : TTipoPerfil;
    function fRetTipoPerfil(value: String):TTipoPerfil;
    function fCalculaRegistros(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pCalculaRegistros;
    procedure pInsereDados(TipoPerfil: TTipoPerfil);
    procedure pAtribuiValoresEmEdicao(strPefil, strAlias: String);
    procedure pAtribuiValoresEmDataSet(strPefil, strAlias: String);
    function fUtilizaValoresEmEdicaoExterno(TipoPerfil: TTipoPerfil): Boolean;
    procedure pLocalizaRegistroEmFoco;



  protected
    cdsExterno: TUniClientDataSet;
    fltRedAliCargaMediaEmp: Double;

    strPerfilAtual: String;
    blnRedChecked: Boolean;
    strEstado: string;
    fltAlqInterna: Double;
    fltBaseICMSSt: Double;
    fltIva: Double;

    { Private declarations }
  public
     class procedure pExibirAliquotaCargaMedia(ACdsDados: TUniClientDataSet; AstrPerfilAtual: String;
        AblnRedChecked: Boolean; AstrEstado: string; AfltAlqInterna: Double; AfltBaseICMSSt: Double; AfltIva: Double);
    { Public declarations }
  end;


implementation

uses untFuncoesSimples, untGravando, untConstantes;

{$R *.dfm}

{ TfrmAbfIcmDetalheAliquotaCargaMedia }
procedure TfrmAbfIcmDetalheAliquotaCargaMedia.pAtribuiValoresEmEdicao(strPefil, strAlias: String);
Begin
  cdsDadosPERFIL.AsString := strPefil;


  cdsDadosUNIFED.AsString := strEstado;
  cdsDadosBASEST.AsFloat  := fltBaseICMSSt;
  cdsDadosALQINT.AsFloat  := fltAlqInterna;
  If blnRedChecked Then
    cdsDadosREDEMP.AsFloat  := fltRedAliCargaMediaEmp
  Else
    cdsDadosREDEMP.AsFloat  := 0;
  cdsDadosCARLIQ.AsFloat :=  cdsDadosALQINT.AsFloat * (( 100 - cdsDadosREDEMP.AsFloat )/100);
  cdsDadosALQIVA.AsFloat  := fltIva;
  cdsDadosKEY.AsString := strAlias + strEstado;
  cdsDadosFORCAL.AsString := 'CÁLCULO NORMAL';
End;

procedure TfrmAbfIcmDetalheAliquotaCargaMedia.pAtribuiValoresEmDataSet(strPefil, strAlias: String);
Begin
  cdsDadosPERFIL.AsString := strPefil;
  cdsDadosUNIFED.AsString := cdsExterno.FieldByName('ABF_ESTADO').AsString;
  cdsDadosBASEST.AsFloat  := cdsExterno.FieldByName('ABF_BASRET' + strAlias).AsFloat;
  cdsDadosALQINT.AsFloat  := cdsExterno.FieldByName('ABF_ALQRET' + strAlias).AsFloat;
  If cdsExterno.FieldByName('ABF_ALQCLI' + strAlias).AsInteger =  1 Then
    cdsDadosREDEMP.AsFloat  := fltRedAliCargaMediaEmp
  Else
    cdsDadosREDEMP.AsFloat  := 0;
  cdsDadosCARLIQ.AsFloat :=  cdsDadosALQINT.AsFloat * (( 100 - cdsDadosREDEMP.AsFloat )/100);
  cdsDadosALQIVA.AsFloat  := cdsExterno.FieldByName('ABF_IVA_ST' + strAlias).AsFloat;

  cdsDadosKEY.AsString := strAlias + cdsExterno.FieldByName('ABF_ESTADO').AsString;
  cdsDadosFORCAL.AsString := 'CÁLCULO NORMAL';
End;

function TfrmAbfIcmDetalheAliquotaCargaMedia.fUtilizaValoresEmEdicaoExterno(TipoPerfil: TTipoPerfil): Boolean;
begin
  Result := False;
  If (PerfilExterno = TipoPerfil) Then
    If cdsExterno.FieldByName('ABF_ESTADO').AsString = strEstado Then
      Result := True;
End;

procedure TfrmAbfIcmDetalheAliquotaCargaMedia.pInsereDados(TipoPerfil: TTipoPerfil);
 var strAlias: String;
     strPefil: string;
     const cPEF = 0;
     const cPEJ = 1;
     const cPER = 2;
     const cPES = 3;
     const cPSI = 4;
     const cPII = 5;

begin
  Case TipoPerfil Of
    tppfPEF : strAlias := '_ENT_PEF';
    tppfPEJ : strAlias := '_ENT_PEJ';
    tppfPER : strAlias := '_ENT_PER';
    tppfPES : strAlias := '_ENT_PES';
    tppfPSI : strAlias := '_ENT_PSI';
    tppfPII : strAlias := '_ENT_PII';
  end;

  Case TipoPerfil Of
    tppfPEF : strPefil := CNS_TIP_ABF[cPEF, 1];
    tppfPEJ : strPefil := CNS_TIP_ABF[cPEJ, 1];
    tppfPER : strPefil := CNS_TIP_ABF[cPER, 1];
    tppfPES : strPefil := CNS_TIP_ABF[cPES, 1];
    tppfPSI : strPefil := CNS_TIP_ABF[cPSI, 1];
    tppfPII : strPefil := CNS_TIP_ABF[cPII, 1];
  end;

  cdsDados.Insert;

   if fUtilizaValoresEmEdicaoExterno(TipoPerfil) Then
      pAtribuiValoresEmEdicao(strPefil, strAlias)
   Else
      pAtribuiValoresEmDataSet(strPefil, strAlias)
end;

procedure TfrmAbfIcmDetalheAliquotaCargaMedia.pLocalizaRegistroEmFoco;
begin
  cdsDados.FindKey(['_ENT_'+strPerfilAtual + strEstado]);
end;

function TfrmAbfIcmDetalheAliquotaCargaMedia.fCalculaRegistros(pgbStatus: TcxProgressBar = Nil): Boolean;
begin
  cdsExterno.First;

  PerfilExterno :=  fRetTipoPerfil(strPerfilAtual);
  pgbStatus.Properties.Max := cdsExterno.RecordCount -1;
  while not cdsExterno.Eof Do
  Begin
    pInsereDados(tppfPEF);
    pInsereDados(tppfPEJ);
    pInsereDados(tppfPER);
    pInsereDados(tppfPES);
    pInsereDados(tppfPSI);
    pInsereDados(tppfPII);
    cdsExterno.Next;
    pgbStatus.Position := cdsExterno.recNo;
    Application.ProcessMessages;
  End;

  cdsDados.IndexFieldNames := 'KEY';

  Result := True;

end;

procedure TfrmAbfIcmDetalheAliquotaCargaMedia.FormCreate(Sender: TObject);
begin
  inherited;
  fltRedAliCargaMediaEmp := fRetReducaoAliquotaCargaMediaEmpresa(VS_StrCodEmp);
end;

function TfrmAbfIcmDetalheAliquotaCargaMedia.fRetTipoPerfil(
  value: String): TTipoPerfil;
begin
  If Value =  'PEF' Then
    Result :=  tppfPEF
  Else If Value = 'PEJ' Then
    Result :=  tppfPEJ
  Else If Value = 'PER' Then
    Result :=   tppfPER
  Else If Value = 'PSI' Then
    Result :=   tppfPSI
  Else If Value = 'PII' Then
    Result :=  tppfPII
  Else
    Result := tppfPES
end;

procedure TfrmAbfIcmDetalheAliquotaCargaMedia.pCalculaRegistros;
var frmGravando: TFrmGravando;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  frmGravando.fExecutarAcao := fCalculaRegistros;
  frmGravando.Caption := 'Calculando...';
  frmGravando.ShowModal;
end;

class procedure TfrmAbfIcmDetalheAliquotaCargaMedia.pExibirAliquotaCargaMedia(ACdsDados: TUniClientDataSet;
   AstrPerfilAtual: String; AblnRedChecked: Boolean; AstrEstado: string; AfltAlqInterna: Double; AfltBaseICMSSt: Double; AfltIva: Double);
var frmAbfIcmDetalheAliquotaCargaMedia: TfrmAbfIcmDetalheAliquotaCargaMedia;

begin
   pCriarFormularios(TfrmAbfIcmDetalheAliquotaCargaMedia, frmAbfIcmDetalheAliquotaCargaMedia);
   Try
     frmAbfIcmDetalheAliquotaCargaMedia.cdsExterno := ACdsDados;
     ACdsDados.Filtered := False;

     frmAbfIcmDetalheAliquotaCargaMedia.strPerfilAtual := AstrPerfilAtual;
     frmAbfIcmDetalheAliquotaCargaMedia.blnRedChecked  := AblnRedChecked;
     frmAbfIcmDetalheAliquotaCargaMedia.strEstado      := AstrEstado;
     frmAbfIcmDetalheAliquotaCargaMedia.fltAlqInterna  := AfltAlqInterna;
     frmAbfIcmDetalheAliquotaCargaMedia.fltBaseICMSSt  := AfltBaseICMSSt;
     frmAbfIcmDetalheAliquotaCargaMedia.fltIva  := AfltIva;

     frmAbfIcmDetalheAliquotaCargaMedia.pCalculaRegistros;
     frmAbfIcmDetalheAliquotaCargaMedia.cxGrid1DBTableView1.ViewData.Expand(True);

     frmAbfIcmDetalheAliquotaCargaMedia.pLocalizaRegistroEmFoco;

     frmAbfIcmDetalheAliquotaCargaMedia.Showmodal;
   Finally
     FreeAndNil(frmAbfIcmDetalheAliquotaCargaMedia)
   End;
end;

end.
