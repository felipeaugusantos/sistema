unit Principal.View.Frame.FMXPainelRotasFiltros;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Edit, FMX.DateTimeCtrls,
  System.ImageList, FMX.ImgList, FMX.MultiResBitmap, System.StrUtils,
  TaEntregue.Romaneios.Interfaces;

type
  TframeFiltros = class(TFrame)
    recBordas: TRectangle;
    lblFiltros: TLabel;
    recEdtPesquisa: TRectangle;
    imgPesquisa: TImage;
    lblPesquisa: TLabel;
    edtPesquisa: TEdit;
    recDataIni: TRectangle;
    imgDataIni: TImage;
    lblStatus: TLabel;
    recStatus: TRectangle;
    imgEntreguesOFF: TImage;
    imgPendentesOFF: TImage;
    imgEmTransitoOFF: TImage;
    timerCursor: TTimer;
    imgEmTransitoON: TImage;
    imgPendentesON: TImage;
    imgEntreguesON: TImage;
    edtDataIni: TDateEdit;
    lblDe: TLabel;
    recDataFim: TRectangle;
    imgDataFim: TImage;
    edtDataFim: TDateEdit;
    lblAte: TLabel;
    procedure edtPesquisaEnter(Sender: TObject);
    procedure edtPesquisaExit(Sender: TObject);
    procedure imgEntreguesOFFClick(Sender: TObject);
    procedure edtDataIniExit(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    function MontaFiltroPorStatus: TArray<IStatus>;
    function RetornaStatus(Status: IStatus): String;
  end;

implementation

{$R *.fmx}

procedure TframeFiltros.edtDataIniExit(Sender: TObject);
begin
  edtDataFim.SetFocus;
end;

procedure TframeFiltros.edtPesquisaEnter(Sender: TObject);
begin
  If (edtPesquisa.Text = EmptyStr) Then
  Begin
    lblPesquisa.Visible := False;
  End;
end;

procedure TframeFiltros.edtPesquisaExit(Sender: TObject);
begin
  If (edtPesquisa.Text = EmptyStr) Then
  Begin
    lblPesquisa.Visible := True;
  End;

  edtDataIni.SetFocus;
end;

procedure TframeFiltros.imgEntreguesOFFClick(Sender: TObject);
Var
  LNome, LSufixo: String;
  LLigar : Boolean;
  LImgON, LImgOFF: TImage;
begin
  LNome  := String(TImage(Sender).Name);
  LLigar := LNome.Contains('OFF');

  If (LLigar) Then
    LSufixo := Leftstr(LNome, Length(LNome) - 3)
  Else
    LSufixo := Leftstr(LNome, Length(LNome) - 2);

  LImgON  := TImage(FindComponent(LSufixo + 'ON'));
  LImgOFF := TImage(FindComponent(LSufixo + 'OFF'));

  LImgON.Visible  := LLigar;
  LImgOFF.Visible := Not LLigar;
end;

function TframeFiltros.MontaFiltroPorStatus: TArray<IStatus>;
begin
  if imgEntreguesON.Visible then
  begin
    SetLength(Result, Length(Result)+1);
    Result[Length(Result)-1] := rmFinalizado;
  end;

  if imgPendentesON.Visible then
  begin
    SetLength(Result, Length(Result)+1);
    Result[Length(Result)-1] := rmNaoIniciado;
  end;

  if imgEmTransitoON.Visible then
  begin
    SetLength(Result, Length(Result)+1);
    Result[Length(Result)-1] := rmACaminho;
  end;

end;

function TframeFiltros.RetornaStatus(Status: IStatus): String;
begin
  case status of
    rmFinalizado:  Result := 'FINALIZADO';
    rmNaoIniciado: Result := 'NAO INICIADO';
    rmACaminho:    Result := 'EM TRANSITO';
  end;
end;

end.
