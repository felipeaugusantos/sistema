unit untConsultaFatLotes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB,
  Uni, ExtCtrls, StdCtrls, ComCtrls, Buttons, Grids, DBGridCitel, DBGrids,
  BitBtnLockedIncrem, MemDS, DBAccess, untConsultaComp;

type
  TfrmConsultaFatLotes = class(TfrmConsultaComp)
    btnMostraEstoque: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMostraEstoqueClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure pAtuIndice(intIndice: Integer); override;
  public
    { Public declarations }
    strCodIte: String;
    strNumLot: String;
  end;

var
  frmConsultaFatLotes: TfrmConsultaFatLotes;

implementation

uses untFuncoesSimples, untCadLotesConsulta;

{$R *.dfm}

procedure TfrmConsultaFatLotes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_F6 Then
  Begin
    btnMostraEstoque.Click;
  End
  Else
    inherited;
end;

procedure TfrmConsultaFatLotes.btnMostraEstoqueClick(Sender: TObject);
begin
  inherited;
  If Not btnMostraEstoque.Visible Then
    Exit;

  Try
    pCriarFormularios(TfrmCadLotesConsulta, frmCadLotesConsulta);
    frmCadLotesConsulta.strCodIte := strCodIte;
    frmCadLotesConsulta.strNumLot := qryConsulta.FieldByName('LOT_NUMLOT').AsString;
    frmCadLotesConsulta.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmConsultaFatLotes.btnMostraEstoqueClick]');
    end;
  End;
  pFreeAndNil(frmCadLotesConsulta);

end;

procedure TfrmConsultaFatLotes.FormCreate(Sender: TObject);
begin
  inherited;
  strCodIte := '';
end;

procedure TfrmConsultaFatLotes.pAtuIndice(intIndice: Integer);
begin
  inherited;
  If qryConsulta.Active Then
  Begin
    If qryConsulta.FindField( 'LOT_NUMLOT' ) <> Nil Then
    Begin
      qryConsulta.FieldByName('LOT_NUMLOT').Visible := False;
      btnMostraEstoque.Visible := Not fEmptyStr(strCodIte);
    End
    Else
      btnMostraEstoque.Visible := False;
  End;
end;

end.
