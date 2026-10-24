unit untConsultaCadPpgVenda;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untConsultaComp, DB, 
   Uni, ExtCtrls, ComCtrls, Buttons, Grids,
  DBGridCitel, DBGrids, EditFocus, Mask, DBCtrls, DBEditFocus,
  BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaCadPpgVenda = class(TfrmConsultaComp)
    pnlDados: TPanel;
    edtVenConLt: TEditFocus;
    edtVenDilLt: TEditFocus;
    edtVenConGl: TEditFocus;
    edtVenDilGl: TEditFocus;
    lblVenConLt: TLabel;
    lblVenConGl: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormShow(Sender: TObject);
    procedure edtFiltro1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtFiltro1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExecutaTarefaClick(Sender: TObject);
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
  frmConsultaCadPpgVenda: TfrmConsultaCadPpgVenda;

implementation

uses untConsulta, untFuncEspecificas, untFuncoesSimples,untIConfTinta, untTintaMaquina;

{$R *.dfm}

procedure TfrmConsultaCadPpgVenda.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;
end;

procedure TfrmConsultaCadPpgVenda.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
  pCalculaDados;
end;

procedure TfrmConsultaCadPpgVenda.pDesabilitaColunas;
begin
  qryConsulta.FieldByName('PPG_PREVEN').Visible    := False;
  qryConsulta.FieldByName('PPG_PREVEN_GL').Visible := False;
  pAplicaMascara;
end;

procedure TfrmConsultaCadPpgVenda.pAtuIndice(intIndice: Integer);
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

procedure TfrmConsultaCadPpgVenda.pAplicaMascara;
begin
  (qryConsulta.FieldByName('PPG_PREVEN') As TFloatField).DisplayFormat    := '#,####0.0000';
  (qryConsulta.FieldByName('PPG_PREVEN_GL') As TFloatField).DisplayFormat := '#,####0.0000';
end;

procedure TfrmConsultaCadPpgVenda.pAtualizaDados(Data: TDataSet);
begin
  pAplicaMascara;
  pCalculaDados;
end;

procedure TfrmConsultaCadPpgVenda.FormCreate(Sender: TObject);
begin
  inherited;
  qryConsulta.AfterScroll := pAtualizaDados;
end;

procedure TfrmConsultaCadPpgVenda.pCalculaDados;
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

    edtVenConLt.Text := '0,000';
    edtVenDilLt.Text := '0,000';

    edtVenConGl.Text := '0,000';
    edtVenDilGl.Text := '0,000';

    fltPreLt    := fStrToFloat(conf.fGet('EMBPPG')); //fStrToFloat(fArqIniTinta(0, 'PPG', 'EMBPPG', '0'));
    fltPreGl    := fStrToFloat(conf.fGet('GALPPG')); //fStrToFloat(fArqIniTinta(0, 'PPG', 'GALPPG', '0'));

    fltPreVenLt := FieldByName('PPG_PREVEN').AsFloat;
    fltPreVenGl := FieldByName('PPG_PREVEN_GL').AsFloat;

    If (fltPreVenLt > 0.0) Then
    Begin
      edtVenConLt.Text := FloatToStrF(fltPreVenLt + fltPreLt, ffFixed, 12, 2);
      edtVenDilLt.Text := FloatToStrF(fRetDiluidoPpg(fltPreVenLt, False) + fltPreLt, ffFixed, 12, 2);
    End;

    {**************************************************}
    {* ----------------> ATENÇÃO <------------------- *}
    {* O PREÇO A SER PASSADO NA FUNÇÃO fRetDiluidoPpg *}
    {* É O PREÇO ORIGINAL E NAO O PREÇO DO GALÃO      *}
    {***********************************************MV*}
    If (fltPreVenGl > 0.0) Then
    Begin
      edtVenConGl.Text := FloatToStrF(fltPreVenGl + fltPreGl, ffFixed, 12, 2);
      edtVenDilGl.Text := FloatToStrF((fRetDiluidoPpg(fltPreVenLt, False) * 3.6) + fltPreGl, ffFixed, 12, 2);
    End;

  End;
end;

procedure TfrmConsultaCadPpgVenda.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadPpgVenda.btnExecutaTarefaClick(Sender: TObject);
begin
  inherited;
//  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' ' + VS_strCodEmp + ' TfrmCadEucNovasFormulas', False);
end;

end.
