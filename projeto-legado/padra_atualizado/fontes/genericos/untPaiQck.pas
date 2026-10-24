unit untPaiQck;

interface

uses
  SysUtils, Types, Classes, Variants, RLParser, RLReport, Controls, {QTypes,}
  Graphics, Forms, Dialogs, StdCtrls, RLPreviewForm;

type
  TfrmPaiQck = class(TForm)
    qckPagina: TRLReport;
    rlbCabecalho: TRLBand;
    rlbTitulo: TRLBand;
    rlbGrupo: TRLGroup;
    rlbTituloGrupo: TRLBand;
    rlbDetalheGrupo: TRLBand;
    rlbResumoGrupo: TRLBand;
    rlbDetalhe: TRLBand;
    rlbResumo: TRLBand;
    rllNomeEmpresa: TRLLabel;
    rllNomeRelatorio: TRLLabel;
    rllDataRelatorio: TRLSystemInfo;
    rllNomeForm: TRLLabel;
    rllOrdem: TRLLabel;
    RLPanel1: TRLPanel;
    rllQtdReg: TRLSystemInfo;
    rllPagina: TRLLabel;
    RLExpressionParser1: TRLExpressionParser;
    rpsSetup: TRLPreviewSetup;
    procedure rllDataRelatorioBeforePrint(Sender: TObject;
      var Text: String; var PrintIt: Boolean);
    procedure rllNomeEmpresaBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllNomeFormBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllQtdRegBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure rllPaginaBeforePrint(Sender: TObject; var Text: String;
      var PrintIt: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure rlbDetalheAfterPrint(Sender: TObject);
    procedure rlbDetalheGrupoAfterPrint(Sender: TObject);
    procedure qckPaginaBeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    { Private declarations }
  protected
    Cor1: TColor;
    Cor2: TColor;
  public
    { Public declarations }
    strOrdem: String;
  end;

var
  frmPaiQck: TfrmPaiQck;

implementation

uses untfuncoesSimples, untCfgRel;

{$R *.dfm}

procedure TfrmPaiQck.rllDataRelatorioBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'EMITIDO EM ' + Text;
end;

procedure TfrmPaiQck.rllNomeEmpresaBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := fRetNomeEmpresa;
end;

procedure TfrmPaiQck.rllNomeFormBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := '[ ' + Self.Name + ' ]';
end;

procedure TfrmPaiQck.rllQtdRegBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'REGISTROS IMPRESSOS: ' + fPadL(Text, 6, '0');
end;

procedure TfrmPaiQck.rllPaginaBeforePrint(Sender: TObject;
  var Text: String; var PrintIt: Boolean);
begin
  Text := 'PÁGINA ' + IntToStr(qckPagina.PageNumber);
end;

procedure TfrmPaiQck.FormCreate(Sender: TObject);
  Var
    strCor: String;
begin
  qckPagina.PrintDialog := TCfgRel.VS_blnDlgPri;
  Cor1 := clWhite;

  strCor := fCfgSis('CORZEB');

  If (Not fEmptyStr(strCor)) Then
    Cor2 := StrToInt(strCor)
  Else
    Cor2 := clWhite;
end;

procedure TfrmPaiQck.rlbDetalheAfterPrint(Sender: TObject);
begin
  If (rlbDetalhe.Color = Cor1) Then
    rlbDetalhe.Color := Cor2
  Else
    rlbDetalhe.Color := Cor1;
end;

procedure TfrmPaiQck.rlbDetalheGrupoAfterPrint(Sender: TObject);
begin
  If (rlbDetalheGrupo.Color = Cor1) Then
    rlbDetalheGrupo.Color := Cor2
  Else
    rlbDetalheGrupo.Color := Cor1;
end;

procedure TfrmPaiQck.qckPaginaBeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin

  //*************************************************//
  // CARREGA O ZOOM INICIAL DOS RELATORIOS           //
  //**********************************************ED*//

end;

end.

