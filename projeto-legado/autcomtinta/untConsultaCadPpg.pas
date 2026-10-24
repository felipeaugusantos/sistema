unit untConsultaCadPpg;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms, 
  Dialogs, StdCtrls, untConsultaComp, DB, 
   Uni, ExtCtrls, ComCtrls, Buttons, Grids,
  DBGridCitel, DBGrids, EditFocus, Mask, DBCtrls, DBEditFocus,
  BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaCadPpg = class(TfrmConsultaComp)
    pnlDados: TPanel;
    lblVenConLt: TLabel;
    lblVenConGl: TLabel;
    lblCusConLt: TLabel;
    lblCusConGl: TLabel;
    edtVenConLt: TEditFocus;
    edtVenDilLt: TEditFocus;
    edtCusConLt: TEditFocus;
    edtCusDilLt: TEditFocus;
    edtVenConGl: TEditFocus;
    edtVenDilGl: TEditFocus;
    edtCusConGl: TEditFocus;
    edtCusDilGl: TEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
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
  frmConsultaCadPpg: TfrmConsultaCadPpg;

implementation

uses untConsulta,  untFuncEspecificas, untFuncoesSimples, unticonfTinta, unttintamaquina;

{$R *.dfm}

procedure TfrmConsultaCadPpg.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;
end;

procedure TfrmConsultaCadPpg.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
  pCalculaDados;
end;

procedure TfrmConsultaCadPpg.pDesabilitaColunas;
begin
  qryConsulta.FieldByName('PPG_PRECUS').Visible    := False;
  qryConsulta.FieldByName('PPG_PREVEN').Visible    := False;
  qryConsulta.FieldByName('PPG_PRECUS_GL').Visible := False;
  qryConsulta.FieldByName('PPG_PREVEN_GL').Visible := False;

  pAplicaMascara;
end;

procedure TfrmConsultaCadPpg.pAtuIndice(intIndice: Integer);
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

procedure TfrmConsultaCadPpg.pAplicaMascara;
begin
  (qryConsulta.FieldByName('PPG_PRECUS') As TFloatField).DisplayFormat    := '#,####0.0000';
  (qryConsulta.FieldByName('PPG_PREVEN') As TFloatField).DisplayFormat    := '#,####0.0000';
  (qryConsulta.FieldByName('PPG_PRECUS_GL') As TFloatField).DisplayFormat := '#,####0.0000';
  (qryConsulta.FieldByName('PPG_PREVEN_GL') As TFloatField).DisplayFormat := '#,####0.0000';
end;

procedure TfrmConsultaCadPpg.pAtualizaDados(Data: TDataSet);
begin
  pAplicaMascara;
  pCalculaDados;
end;

procedure TfrmConsultaCadPpg.FormCreate(Sender: TObject);
begin
  inherited;
  qryConsulta.AfterScroll := pAtualizaDados;
end;

procedure TfrmConsultaCadPpg.pCalculaDados;
  Var
    fltPreVenLt: Double;
    fltPreCusLt: Double;
    fltPreVenGl: Double;
    fltPreCusGl: Double;

    fltPreLt: Double; // Preço da Embalagem Litro
    fltPreGl: Double; // Preço da Embalagem Galão
    conf: IConfTinta;
begin
  conf := fGetConfTinta('PPG');

  With qryConsulta Do
  Begin

    edtVenConLt.Text := '0,00';
    edtVenDilLt.Text := '0,00';
    edtCusConLt.Text := '0,00';
    edtCusDilLt.Text := '0,00';

    edtVenConGl.Text := '0,00';
    edtVenDilGl.Text := '0,00';
    edtCusConGl.Text := '0,00';
    edtCusDilGl.Text := '0,00';

    fltPreLt    := fFormataFloat(fStrToFloat(conf.fGet('EMBPPG')),02); //fFormataFloat(fStrToFloat(fArqIniTinta(0, 'PPG', 'EMBPPG', '0')),02);
    fltPreGl    := fFormataFloat(fStrToFloat(conf.fGet('GALPPG')),02); //fFormataFloat(fStrToFloat(fArqIniTinta(0, 'PPG', 'GALPPG', '0')),02);

    fltPreVenLt := fFormataFloat(FieldByName('PPG_PREVEN').AsFloat,02);
    fltPreCusLt := fFormataFloat(FieldByName('PPG_PRECUS').AsFloat,02);
    fltPreVenGl := fFormataFloat(FieldByName('PPG_PREVEN_GL').AsFloat,02);
    fltPreCusGl := fFormataFloat(FieldByName('PPG_PRECUS_GL').AsFloat,02);

    If (fltPreVenLt > 0.0) Then
    Begin
      edtVenConLt.Text := FloatToStrF( fFormataFloat(fltPreVenLt + fltPreLt,02), ffFixed, 12, 2);
      edtVenDilLt.Text := FloatToStrF( fFormataFloat(fRetDiluidoPpg(fltPreVenLt, False) + fltPreLt,02), ffFixed, 12, 2);
    End;

    If (fltPreCusLt > 0.0) Then
    Begin
      edtCusConLt.Text := FloatToStrF( fFormataFloat(fltPreCusLt + fltPreLt,02), ffFixed, 12, 2);
      edtCusDilLt.Text := FloatToStrF( fFormataFloat(fRetDiluidoPpg(fltPreCusLt, True) + fltPreLt,02), ffFixed, 12, 2);
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

    If (fltPreCusGl > 0.0) Then
    Begin
      edtCusConGl.Text := FloatToStrF(fFormataFloat(fltPreCusGl + fltPreGl,02), ffFixed, 12, 2);
      edtCusDilGl.Text := FloatToStrF(fFormataFloat(fFormataFloat(fRetDiluidoPpg(fltPreCusLt, True) * 3.6,02) + fltPreGl,02), ffFixed, 12, 2);
    End;
  End;
end;

procedure TfrmConsultaCadPpg.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

end.
