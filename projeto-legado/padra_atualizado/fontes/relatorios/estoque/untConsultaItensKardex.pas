unit untConsultaItensKardex;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB,
  Uni, ExtCtrls, StdCtrls, ComCtrls, Buttons, Grids, DBGridCitel, DBGrids,
  BitBtnLockedIncrem, MemDS, DBAccess, untConsultaComp;

type
  TfrmConsultaItensKardex = class(TfrmConsultaComp)
//    Shape1: TShape;
    Label3: TLabel;
    procedure btnExecutaTarefaClick(Sender: TObject);
    procedure dbgConsultaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultaItensKardex: TfrmConsultaItensKardex;

implementation

uses untFatMostraEstoqueEmp, untFuncoesSimples;

{$R *.dfm}

procedure TfrmConsultaItensKardex.btnExecutaTarefaClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(TfrmFatMostraEstoqueEmp, frmFatMostraEstoqueEmp);
    frmFatMostraEstoqueEmp.strCodIte    := qryConsulta.FieldByName('Código').AsString;
    frmFatMostraEstoqueEmp.edtItem.Text := qryConsulta.FieldByName('Código').AsString + ' - ' +
                                              qryConsulta.FieldByName('Descrição').AsString;
    frmFatMostraEstoqueEmp.showModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[pMostraEstoqueLojas]');
  End;

  pFreeAndNil(frmFatMostraEstoqueEmp);
end;

procedure TfrmConsultaItensKardex.dbgConsultaDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;

  If qryConsulta.FieldByName('Ativo').AsString = 'N' Then
    dbgConsulta.Canvas.Brush.Color := clRed;

  dbgConsulta.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

end.
