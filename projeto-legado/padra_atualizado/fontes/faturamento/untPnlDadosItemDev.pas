unit untPnlDadosItemDev;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, UniClientDataSet, ExtCtrls, Uni,
  DB, Mask, DBCtrls, DBEditFocus, EditFocus, untFraConsultaImgPro;

type
  TfrmPnlDadosItemDev = class(TForm)
    pnlDadosItem: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    dbeQtdIte: TDBEditFocus;
    dbeUnitar: TDBEditFocus;
    dbeTotIte: TDBEditFocus;
    dbeCodGru: TDBEditFocus;
    dbeCodIte: TDBEditFocus;
    dtsConsulta: TDataSource;
    pnlImagem: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pcdsConsultaAfterScroll(DateSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    blnNaoTecla : Boolean;
  public
    { Public declarations }
    cdsConsulta  : TUniClientDataSet;
    strNomForm   : String;
    strCodIte    : String;
    bnlLigaScroll: Boolean;
    fraConsultaImgPro: TFraConsultaImgPro;
    constructor Create(AOwner: TComponent); reintroduce; virtual;
    procedure pIniciouNavegacaoGridConsulta;
    procedure pParouNavegacaoGridConsulta;
  end;
  TfrmPnlDadosItemDevClass = Class Of TfrmPnlDadosItemDev;

var
  frmPnlDadosItemDev: TfrmPnlDadosItemDev;

implementation

{$R *.dfm}

uses untCadProFoto, untFuncoesGen;

constructor TfrmPnlDadosItemDev.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fraConsultaImgPro := TFraConsultaImgPro.Create(Self);
  fraConsultaImgPro.Parent := pnlImagem;
  pnlImagem.Visible := fCfgSis('IMGDEV', varBoolean);
end;

procedure TfrmPnlDadosItemDev.FormCreate(Sender: TObject);
begin
  bnlLigaScroll := False;
end;

procedure TfrmPnlDadosItemDev.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//
end;

procedure TfrmPnlDadosItemDev.FormShow(Sender: TObject);
begin
  dtsConsulta.DataSet := cdsConsulta;
  cdsConsulta.First;
  blnNaoTecla := True;
end;

procedure TfrmPnlDadosItemDev.pcdsConsultaAfterScroll(DateSet: TDataSet);
begin
 TfrmCadProFoto.pMostraImagemProduto(fraConsultaImgPro.ImgPro, fraConsultaImgPro.lblErrImg, pnlImagem.Visible, cdsConsulta.FieldByName('DET_CODITE').AsString);
end;

procedure TfrmPnlDadosItemDev.pIniciouNavegacaoGridConsulta;
begin
  pcdsConsultaAfterScroll(cdsConsulta);
end;

procedure TfrmPnlDadosItemDev.pParouNavegacaoGridConsulta;
begin
  If (Not Self.Showing) Then
    Exit;

  pcdsConsultaAfterScroll(cdsConsulta);
end;

end.
