unit untConsultaCadCtaReceber;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untConsultaComp, DB, Uni, ExtCtrls, StdCtrls, ComCtrls, Buttons,
  Grids, DBGridCitel, DBGrids, BitBtnLockedIncrem, MemDS, DBAccess;

type
  TfrmConsultaCadCtaReceber = class(TfrmConsultaComp)
    pnlAuxiliar: TPanel;
    btnEnviarEmail: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnEnviarEmailClick(Sender: TObject);
    procedure qryConsultaAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    strNomArq: String;
  protected
    procedure pAtuIndice(intIndice: Integer); override;
  public
    { Public declarations }
  end;

var
  frmConsultaCadCtaReceber: TfrmConsultaCadCtaReceber;

implementation

uses untfuncoesSimples, untConsulta, untFuncoesAuxiliares;

{$R *.dfm}

procedure TfrmConsultaCadCtaReceber.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F9) Then
  Begin

    btnEnviarEmail.Click;

  End;
end;

procedure TfrmConsultaCadCtaReceber.pAtuIndice(intIndice: Integer);
  Var
    strSQLOrder: String;
begin
  strSQLOrder := fRetOrderBy(lstConInd.Strings[intIndice]);

  inherited;

  btnEnviarEmail.Visible := (qryConsulta.FieldByName('Espécie').AsString = 'AG');

end;

procedure TfrmConsultaCadCtaReceber.btnEnviarEmailClick(Sender: TObject);
begin
  inherited;

  If (qryConsulta.FieldByName('Espécie').AsString <> 'AG') Then
    Exit;

  If (intCaixa = 1) Then
    strNomArq := 'DUPAGR'
  Else
    strNomArq := 'DUPAGRX';

  pMostraDuplicatasAgrupadas(strNomArq,
                             qryConsulta.FieldByName('Duplicata').AsString,
                             qryConsulta.FieldByName('Empresa').AsString,
                             qryConsulta.FieldByName('Cliente').AsString,
                             FALSE{nao veio pelo Resumo de Caixa});

end;

procedure TfrmConsultaCadCtaReceber.qryConsultaAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  btnEnviarEmail.Visible := (DataSet.FieldByName('Espécie').AsString = 'AG');
end;

end.

