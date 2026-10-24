unit untRelCartaoExtratoConfirmacao;

interface

uses
  System.SysUtils, System.Classes, frxDesgn, Data.DB, Datasnap.DBClient,
  UniClientDataSet, frxClass, frxDBSet, frxExportPDF;

type
  TfrmRelCartaoExtratoConfirmacao = class(TDataModule)
    frxExtratoCartoes: TfrxReport;
    frxDBExtratoCartoes: TfrxDBDataset;
    UniClientDataSetExtrato: TUniClientDataSet;
    UniClientDataSetExtratoEXT_NUM_PV: TStringField;
    UniClientDataSetExtratoEXT_CODAUT: TStringField;
    UniClientDataSetExtratoEXT_NUMNSU: TStringField;
    UniClientDataSetExtratoEXT_PARCEL: TStringField;
    UniClientDataSetExtratoEXT_DTACUP: TDateField;
    UniClientDataSetExtratoEXT_DTAVEN: TDateField;
    UniClientDataSetExtratoEXT_VALBRU: TFloatField;
    UniClientDataSetExtratoEXT_VALTAX: TFloatField;
    UniClientDataSetExtratoEXT_VALLIQ: TFloatField;
    UniClientDataSetExtratoEXT_NOMCON: TStringField;
    UniClientDataSetExtratoEXT_STATUS: TStringField;
    frxDesigner1: TfrxDesigner;
    procedure DataModuleCreate(Sender: TObject);
  private
    frxExportaPDF: TfrxPDFExport;
    { Private declarations }
  public
    procedure AbreExtratoConfirmacao(AEmpresa:String; ACorZebra: Integer; ADataset: TDataset);
    { Public declarations }
  end;

var
  frmRelCartaoExtratoConfirmacao: TfrmRelCartaoExtratoConfirmacao;

implementation
Uses untFuncoesSimples;
{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TfrmRelCartaoExtratoConfirmacao }

procedure TfrmRelCartaoExtratoConfirmacao.AbreExtratoConfirmacao(AEmpresa: String; ACorZebra: Integer; ADataset: TDataset);
begin
  frxDBExtratoCartoes.DataSet := ADataset;

  TfrxMemoView(frxExtratoCartoes.FindObject('rllZebra')).Highlight.Color := ACorZebra;
  frxExtratoCartoes.DotMatrixReport             := False;
  frxExtratoCartoes.PrintOptions.PrintMode      := pmScale;
  frxExtratoCartoes.PrintOptions.PrintOnSheet   := 9;
  frxExtratoCartoes.Script.Variables['NOMEMP']  := AEmpresa;

  pPreviewReport('frmRelCartaoExtratoConfirmacao', 'Extrato de Confirmação de Cartões', frmRelCartaoExtratoConfirmacao.frxExtratoCartoes);
end;

procedure TfrmRelCartaoExtratoConfirmacao.DataModuleCreate(Sender: TObject);
begin
  frxExportaPDF := TfrxPDFExport.Create(Self);
end;

end.
