unit untConsultaForEnt;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms, Dialogs,
  StdCtrls, untConsultaComp, DB, Uni, ExtCtrls, ComCtrls, Buttons, Grids,
  DBGridCitel, DBGrids, Mask, DBCtrls, DBEditFocus, BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaForEnt = class(TfrmConsultaComp)
    pnlDadosFor: TPanel;
    Fornecedor: TLabel;
    dbeNomFor: TDBEditFocus;
    dbeEndere: TDBEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    dbeBairro: TDBEditFocus;
    dbeNomCid: TDBEditFocus;
    Label5: TLabel;
    dbeEstado: TDBEditFocus;
    Label6: TLabel;
    Label7: TLabel;
    dbeFon01: TDBEditFocus;
    dbeContat: TDBEditFocus;
    Label8: TLabel;
    procedure FormShow(Sender: TObject);
    procedure edtFiltro1Change(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure pDesabilitaColunas;
  protected
    procedure pAtuIndice(intIndice: Integer); override;
  public
    { Public declarations }
  end;

var
  frmConsultaForEnt: TfrmConsultaForEnt;

implementation

uses untConsulta;

{$R *.dfm}

{ TfrmConsultaForEnt }

procedure TfrmConsultaForEnt.pAtuIndice(intIndice: Integer);
begin
  inherited;
  pDesabilitaColunas;
  {*****************************************}
  {* RETORNA A CONEXÃO COM O GRID          *}
  {**************************************MV*}
  //dtsConsulta.DataSet := qryConsulta;
  qryConsulta.EnableControls;
end;

procedure TfrmConsultaForEnt.FormShow(Sender: TObject);
begin
  inherited;
  {*****************************************}
  {* ESSA VARIAVEL DEIXA POR CONTA DO      *}
  {* PROGRAMADOR RETORNAR A CONEXÃO DO     *}
  {* GRID COM A TABELA                     *}
  {**************************************MV*}
  blnRestauraGrid := False;
end;

procedure TfrmConsultaForEnt.edtFiltro1Change(Sender: TObject);
begin
  inherited;
  pDesabilitaColunas;
end;

procedure TfrmConsultaForEnt.pDesabilitaColunas;
begin
  If qryConsulta.Active Then
  Begin
    If qryConsulta.FindField('FOR_C_G_C_') <> Nil Then
      qryConsulta.FieldByName('FOR_C_G_C_').DisplayLabel := 'CNPJ';
    qryConsulta.FieldByName('FOR_I_E_S_').DisplayLabel := 'Insc. Estadual';
    qryConsulta.FieldByName('CID_ESTADO').DisplayLabel := 'Estado';

    qryConsulta.FieldByName('FOR_ENDERE').Visible := False;
    qryConsulta.FieldByName('CID_NOMCID').Visible := False;
    qryConsulta.FieldByName('FOR_BAIRRO').Visible := False;
    qryConsulta.FieldByName('FOR_CONTAT').Visible := False;
    qryConsulta.FieldByName('FOR_FONE01').Visible := False;
    qryConsulta.FieldByName('AUTOINCREM').Visible := False;
  End;
end;

procedure TfrmConsultaForEnt.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  pDesabilitaColunas;
end;

end.
