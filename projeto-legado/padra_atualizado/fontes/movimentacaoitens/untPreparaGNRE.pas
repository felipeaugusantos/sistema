unit untPreparaGNRE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Datasnap.DBClient,
  UniClientDataSet, cxCurrencyEdit, untFuncoesSimples;

type
  TfrmPreparaGNRE = class(TfrmPaiConfirma)
    cxItensDB: TcxGridDBTableViewCitel;
    cxItensLvl: TcxGridLevel;
    cxItens: TcxGridCitel;
    dtsDados: TDataSource;
    cxItensDBColumn1: TcxGridDBColumn;
    cxItensDBColumn2: TcxGridDBColumn;
    cxItensDBColumn3: TcxGridDBColumn;
    cxItensDBColumn4: TcxGridDBColumn;
    cxItensDBColumn5: TcxGridDBColumn;
    cxItensDBColumn6: TcxGridDBColumn;
    cxItensDBColumn7: TcxGridDBColumn;
    cxItensDBVALGNR: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxItensDBColumn8: TcxGridDBColumn;
    cxItensDBColumn9: TcxGridDBColumn;
    cxItensDBVSTFCP: TcxGridDBColumn;
    cxItensDBCALVFCPST: TcxGridDBColumn;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cxItensDBVALGNRPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  private
    { Private declarations }
    blnIFCPST: Boolean;
  public
    btnConfirma: Boolean;
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TfrmPreparaGNRE.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  btnConfirma := True;
end;

procedure TfrmPreparaGNRE.cxItensDBVALGNRPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  var calc: Double;
begin
  inherited;
  If (VarToStr(DisplayValue) <> '') And (DisplayValue < 0) Then
  begin
    calc := dtsDados.DataSet.FieldByName('VSTCAL').AsFloat -
            dtsDados.DataSet.FieldByName('VSTXML').AsFloat;
    If calc < 0 Then
      calc := 0;
    DisplayValue := calc;
    pMensagemOk('O Valor da GNRE não pode ser negativo.');
  End;

end;

procedure TfrmPreparaGNRE.FormActivate(Sender: TObject);
begin
  inherited;
  btnConfirma := False;
  blnIFCPST := fCfgSis('IFCPST', varBoolean);
  cxItensDBVSTFCP.Visible := blnIFCPST;
  cxItensDBCALVFCPST.Visible := blnIFCPST;

  cxItensDBVALGNR.HeaderHint := 'Valor GNRE = Vr. GNRE = (Vr. Subst. Sistema - Vr. Subst XML)';
  If blnIFCPST Then
    cxItensDBVALGNR.HeaderHint := 'Valor GNRE = Vr. GNRE = (Vr. Subst. Sistema - Vr. Subst XML)+ (Vr. ST FCP Sistema - Vr. ST FCP XML)';
end;

end.
