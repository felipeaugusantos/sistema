unit untConsultaCadPpgGeral;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms, 
  Dialogs, StdCtrls, untConsultaComp, DB, 
   Uni, ExtCtrls, ComCtrls, Buttons, Grids,
  DBGridCitel, DBGrids, EditFocus, Mask, DBCtrls, DBEditFocus,
  BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaCadPpgGeral = class(TfrmConsultaComp)
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
  frmConsultaCadPpgGeral: TfrmConsultaCadPpgGeral;

implementation

uses untConsulta, untFuncEspecificas, untFuncoesSimples,untIConfTinta, untTintaMaquina;

{$R *.dfm}

procedure TfrmConsultaCadPpgGeral.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;
end;

procedure TfrmConsultaCadPpgGeral.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
  pCalculaDados;
end;

procedure TfrmConsultaCadPpgGeral.pDesabilitaColunas;
begin
  qryConsulta.FieldByName('PPG_PREVEN').Visible    := False;
  qryConsulta.FieldByName('PPG_PREVEN_GL').Visible := False;

  pAplicaMascara;
end;

procedure TfrmConsultaCadPpgGeral.pAtuIndice(intIndice: Integer);
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

procedure TfrmConsultaCadPpgGeral.pAplicaMascara;
begin
  (qryConsulta.FieldByName('PPG_PREVEN') As TFloatField).DisplayFormat    := '#,####0.0000';
  (qryConsulta.FieldByName('PPG_PREVEN_GL') As TFloatField).DisplayFormat := '#,####0.0000';
end;

procedure TfrmConsultaCadPpgGeral.pAtualizaDados(Data: TDataSet);
begin
  pAplicaMascara;
  pCalculaDados;
end;

procedure TfrmConsultaCadPpgGeral.FormCreate(Sender: TObject);
begin
  inherited;
  qryConsulta.AfterScroll := pAtualizaDados;
end;

procedure TfrmConsultaCadPpgGeral.pCalculaDados;
  Var
    fltPreVenLt: Double;
    fltPreVenGl: Double;

    fltPreLt: Double; // Preço da Embalagem Litro
    fltPreGl: Double; // Preço da Embalagem Galão
    conf: IConfTinta;
begin
  conf := fGetConfTinta('PPG');
   
  With qryConsulta Do
  Begin

    edtVenConLt.Text := '0,00';
    edtVenDilLt.Text := '0,00';

    edtVenConGl.Text := '0,00';
    edtVenDilGl.Text := '0,00';

    fltPreLt    := fFormataFloat(fStrToFloat(conf.fGet('EMBPPG')), 02); //fFormataFloat(fStrToFloat(fArqIniTinta(0, 'PPG', 'EMBPPG', '0')), 02);
    fltPreGl    := fFormataFloat(fStrToFloat(conf.fGet('GALPPG')), 02); //fFormataFloat(fStrToFloat(fArqIniTinta(0, 'PPG', 'GALPPG', '0')), 02);

    fltPreVenLt := fFormataFloat(FieldByName('PPG_PREVEN').AsFloat, 02);
    fltPreVenGl := fFormataFloat(FieldByName('PPG_PREVEN_GL').AsFloat, 02);

    If (fltPreVenLt > 0.0) Then
    Begin
      edtVenConLt.Text := FloatToStrF( fFormataFloat(fltPreVenLt + fltPreLt,02), ffFixed, 12, 2);
      edtVenDilLt.Text := FloatToStrF( fFormataFloat(fRetDiluidoPpg(fltPreVenLt, False) + fltPreLt,02), ffFixed, 12, 2);
    End;

    {**************************************************}
    {* ----------------> ATENÇÃO <------------------- *}
    {* O PREÇO A SER PASSADO NA FUNÇÃO fRetDiluidoPpg *}
    {* É O PREÇO ORIGINAL E NAO O PREÇO DO GALÃO      *}
    {***********************************************MV*}
    If (fltPreVenGl > 0.0) Then
    Begin
      edtVenConGl.Text := FloatToStrF(fFormataFloat(fltPreVenGl + fltPreGl,02), ffFixed, 12, 2);
      edtVenDilGl.Text := FloatToStrF(fFormataFloat(fFormataFloat(fRetDiluidoPpg(fltPreVenLt, False) * 3.6,02) + fltPreGl,02), ffFixed, 12, 2);
    End;

  End;

end;

procedure TfrmConsultaCadPpgGeral.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

end.
