unit untConsultaCadZynVenda;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untConsultaComp, DB, 
   Uni, ExtCtrls, ComCtrls, Buttons, Grids,
  DBGridCitel, DBGrids, EditFocus, Mask, DBCtrls, DBEditFocus,
  BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaCadZynVenda = class(TfrmConsultaComp)
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
  frmConsultaCadZynVenda: TfrmConsultaCadZynVenda;

implementation

uses untConsulta,  untFuncEspecificas, untIConfTinta, untTintaMaquina;

{$R *.dfm}

procedure TfrmConsultaCadZynVenda.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;
end;

procedure TfrmConsultaCadZynVenda.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
  pCalculaDados;
end;

procedure TfrmConsultaCadZynVenda.pDesabilitaColunas;
begin
  qryConsulta.FieldByName('ZYN_PREVEN').Visible    := False;
  qryConsulta.FieldByName('ZYN_PREVEN_GL').Visible := False;
  pAplicaMascara;
end;

procedure TfrmConsultaCadZynVenda.pAtuIndice(intIndice: Integer);
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

procedure TfrmConsultaCadZynVenda.pAplicaMascara;
begin
  (qryConsulta.FieldByName('ZYN_PREVEN') As TFloatField).DisplayFormat    := '#,####0.0000';
  (qryConsulta.FieldByName('ZYN_PREVEN_GL') As TFloatField).DisplayFormat := '#,####0.0000';
end;

procedure TfrmConsultaCadZynVenda.pAtualizaDados(Data: TDataSet);
begin
  pAplicaMascara;
  pCalculaDados;
end;

procedure TfrmConsultaCadZynVenda.FormCreate(Sender: TObject);
begin
  inherited;
  qryConsulta.AfterScroll := pAtualizaDados;
end;

procedure TfrmConsultaCadZynVenda.pCalculaDados;
  Var
    fltPreVenLt: Double;
    fltPreVenGl: Double;

    fltPreLt: Double; // Preço da Embalagem Litro
    fltPreGl: Double; // Preço da Embalagem Galão
    conf: IConfTinta;
begin
  conf     := fGetConfTinta('ZYN');
  With qryConsulta Do
  Begin

    edtVenConLt.Text := '0,000';
    edtVenDilLt.Text := '0,000';

    edtVenConGl.Text := '0,000';
    edtVenDilGl.Text := '0,000';

    fltPreLt    := conf.fGetDouble('EMBZYN'); //fStrToFloat(fArqIniTinta(0, 'ZYNAMIX', 'EMBZYN', '0'));
    fltPreGl    := conf.fGetDouble('GALZYN'); //fStrToFloat(fArqIniTinta(0, 'ZYNAMIX', 'GALZYN', '0'));

    fltPreVenLt := FieldByName('ZYN_PREVEN').AsFloat;
    fltPreVenGl := FieldByName('ZYN_PREVEN_GL').AsFloat;

    If (fltPreVenLt > 0.0) Then
    Begin
      edtVenConLt.Text := FloatToStrF(fltPreVenLt + fltPreLt, ffFixed, 12, 2);
      edtVenDilLt.Text := FloatToStrF(fRetDiluidoZyn(fltPreVenLt, False) + fltPreLt, ffFixed, 12, 2);
    End;

    {**************************************************}
    {* ----------------> ATENÇÃO <------------------- *}
    {* O PREÇO A SER PASSADO NA FUNÇÃO fRetDiluidoZyn *}
    {* É O PREÇO ORIGINAL E NAO O PREÇO DO GALÃO      *}
    {***********************************************MV*}
    If (fltPreVenGl > 0.0) Then
    Begin
      edtVenConGl.Text := FloatToStrF(fltPreVenGl + fltPreGl, ffFixed, 12, 2);
      edtVenDilGl.Text := FloatToStrF((fRetDiluidoZyn(fltPreVenLt, False) * 3.6) + fltPreGl, ffFixed, 12, 2);
    End;

  End;
end;

procedure TfrmConsultaCadZynVenda.edtFiltro1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaCadZynVenda.btnExecutaTarefaClick(Sender: TObject);
begin
  inherited;
//  fCriarProcesso('AutTin\AutTin.exe exec ' + strLoginUsuarioLogado + ' ' + VS_strCodEmp + ' TfrmCadEucNovasFormulas', False);
end;

end.
