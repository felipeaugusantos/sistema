unit untMandaeConsultarTracking;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid;

type
  TfrmMandaeConsultarTracking = class(TfrmPai)
    grdDocumentos: TcxGridCitel;
    grdDbDocumentos: TcxGridDBTableViewCitel;
    grdDbDocumentosColumn1: TcxGridDBColumn;
    grdDbDocumentosColumn2: TcxGridDBColumn;
    grdDocumentosLevel1: TcxGridLevel;
    dtsDocumentos: TDataSource;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FstrCodigoDeRastreio : String;
  public
    { Public declarations }
    property strCodigoDeRastreio : String read FstrCodigoDeRastreio write FstrCodigoDeRastreio;
  end;

implementation

Uses MandaeJSON.Classes, MandaeWS.Classes, untFuncoesSimples;

{$R *.dfm}

procedure TfrmMandaeConsultarTracking.FormShow(Sender: TObject);
  var
    LObjMandaeWS           : TMandaeWS;
    LObjMandaeJSONBuilder  : TMandaeJSONBuilder;
    LintCodigoRetorno      : Integer;
    LstrMensagemRetorno    : string;
    LstrJSONRetorno        : string;
begin
  inherited;
  if not fEmptyStr(FstrCodigoDeRastreio) then
  Begin
    LObjMandaeWS          := TMandaeWS.Create;
    LObjMandaeJSONBuilder := TMandaeJSONBuilder.Create;
    Try
      Try
        LstrJSONRetorno := LObjMandaeWS.fComunicar(tsConsultarTracking, LintCodigoRetorno, LstrMensagemRetorno, '', FstrCodigoDeRastreio);

        if LintCodigoRetorno < 400 then
          dtsDocumentos.DataSet := LObjMandaeJSONBuilder.fGerarClientDaConsultaTracking(LstrJSONRetorno);

      Finally
        FreeAndNil(LObjMandaeJSONBuilder);
        FreeAndNil(LObjMandaeWS);
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'');
      End;
    End;
  End;
end;

end.
