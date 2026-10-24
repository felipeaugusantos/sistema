unit untConsultaCadZynGeral;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms, 
  Dialogs, StdCtrls, untConsultaComp, DB, 
   Uni, ExtCtrls, ComCtrls, Buttons, Grids,
  DBGridCitel, DBGrids, EditFocus, Mask, DBCtrls, DBEditFocus, BitBtnLockedIncrem, MemDS,
  DBAccess;

type
  TfrmConsultaCadZynGeral = class(TfrmConsultaComp)
    pnlDados: TPanel;
    lblVenConLt: TLabel;
    lblVenConGl: TLabel;
    edtVenConLt: TEditFocus;
    edtVenDilLt: TEditFocus;
    edtVenConGl: TEditFocus;
    edtVenDilGl: TEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormShow(Sender: TObject);
    procedure edtFiltro1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtFiltro1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure pDesabilitaColunas;
    procedure pAplicaMascara;
    procedure pCalculaDados;

    procedure pAtualizaDados(Data: TDataSet);
  protected
    procedure pAtuIndice(intIndice: Integer); override;
  public
    { Public declarations }
  end;

var
  frmConsultaCadZynGeral: TfrmConsultaCadZynGeral;

implementation

uses untConsulta,  untFuncEspecificas, untFuncoesSimples;

{$R *.dfm}

procedure TfrmConsultaCadZynGeral.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;
end;

procedure TfrmConsultaCadZynGeral.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
  pCalculaDados;
end;

procedure TfrmConsultaCadZynGeral.pDesabilitaColunas;
begin
  qryConsulta.FieldByName('ZYN_PREVEN').Visible    := False;
  qryConsulta.FieldByName('ZYN_PREVEN_GL').Visible := False;

  pAplicaMascara;
end;

procedure TfrmConsultaCadZynGeral.pAtuIndice(intIndice: Integer);
begin
  inherited;
  pDesabilitaColunas;
  {*****************************************}
  {* RETORNA A CONEXÃO COM O GRID          *}
  {**************************************MV*}
  //dtsConsulta.DataSet := qryConsulta;
  qryConsulta.EnableControls;
  pAplicaMascara;
  pCalculaDados;
end;

procedure TfrmConsultaCadZynGeral.pAplicaMascara;
begin
  (qryConsulta.FieldByName('ZYN_PREVEN') As TFloatField).DisplayFormat    := '#,####0.0000';
  (qryConsulta.FieldByName('ZYN_PREVEN_GL') As TFloatField).DisplayFormat := '#,####0.0000';
end;

procedure TfrmConsultaCadZynGeral.pAtualizaDados(Data: TDataSet);
begin
  pAplicaMascara;
  pCalculaDados;
end;

procedure TfrmConsultaCadZynGeral.FormCreate(Sender: TObject);
begin
  inherited;
  qryConsulta.AfterScroll := pAtualizaDados;
end;

procedure TfrmConsultaCadZynGeral.pCalculaDados;
  Var
    fltPreVenLt: Double;
    fltPreVenGl: Double;

    fltPreLt: Double; // Preço da Embalagem Litro
    fltPreGl: Double; // Preço da Embalagem Galão
begin

  With qryConsulta Do
  Begin

    edtVenConLt.Text := '0,00';
    edtVenDilLt.Text := '0,00';

    edtVenConGl.Text := '0,00';
    edtVenDilGl.Text := '0,00';

    fltPreLt    := fFormataFloat(fStrToFloat(fArqIniTinta(0, 'ZYN', 'EMBZYN', '0')), 02);
    fltPreGl    := fFormataFloat(fStrToFloat(fArqIniTinta(0, 'ZYN', 'GALZYN', '0')), 02);

    fltPreVenLt := fFormataFloat(FieldByName('ZYN_PREVEN').AsFloat, 02);
    fltPreVenGl := fFormataFloat(FieldByName('ZYN_PREVEN_GL').AsFloat, 02);

    If (fltPreVenLt > 0.0) Then
    Begin
      edtVenConLt.Text := FloatToStrF( fFormataFloat(fltPreVenLt + fltPreLt,02), ffFixed, 12, 2);
      edtVenDilLt.Text := FloatToStrF( fFormataFloat(fRetDiluidoZyn(fltPreVenLt, False) + fltPreLt,02), ffFixed, 12, 2);
    End;

    {**************************************************}
    {* ----------------> ATENÇÃO <------------------- *}
    {* O PREÇO A SER PASSADO NA FUNÇÃO fRetDiluidoZyn *}
    {* É O PREÇO ORIGINAL E NAO O PREÇO DO GALÃO      *}
    {***********************************************MV*}
    If (fltPreVenGl > 0.0) Then
    Begin
      edtVenConGl.Text := FloatToStrF(fFormataFloat(fltPreVenGl + fltPreGl,02), ffFixed, 12, 2);
      edtVenDilGl.Text := FloatToStrF(fFormataFloat(fFormataFloat(fRetDiluidoZyn(fltPreVenLt, False) * 3.6,02) + fltPreGl,02), ffFixed, 12, 2);
    End;

  End;

end;

procedure TfrmConsultaCadZynGeral.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

end.
