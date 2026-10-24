unit untAlessiGravandoNovasFormulas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untAbstractGravando, AppEvnts, Menus, StdCtrls, CheckLst, Buttons, ExtCtrls, Gauges,
  BitBtnLockedIncrem, ActnList, System.Actions;

type
  TfrmAlessiGravandoNovasFormulas = class(TfrmAbstractGravando)
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAlessiGravandoNovasFormulas: TfrmAlessiGravandoNovasFormulas;

implementation

uses
  untStatusGravando, untFuncoesSimples, untAlessiNovasFormulas;

{$R *.dfm}

procedure TfrmAlessiGravandoNovasFormulas.btnConfirmaGeracaoClick(Sender: TObject);
var
  intIndex: Integer;
begin
  Try
    Try
      for intIndex := 0 to chklstOpcoes.Count - 1 do
      begin
        gravandoExecucao := nil;
        if chklstOpcoes.Checked[intIndex] then
        begin
          case intIndex of
            0: gravandoExecucao := TAlessiNovasFormulas.Create();
          end;
        end;

        if Assigned(gravandoExecucao) then
        begin
          status := sgGravando;
          SetTexto(chklstOpcoes.Items[intIndex] + ' iniciado ');
          gravandoExecucao.Executar(Self);
          if status <> sgCancelado then
          begin
            status := sgFinalizado;
            SetTexto(chklstOpcoes.Items[intIndex] + ' finalizado ');
          end;
          gravandoExecucao := nil;

          if status = sgCancelado then
            Exit;          
        end;
      end;

      fMensagem('SUCESSO', 'Os arquivos foram importados com exíto!', ['&OK']);
    Except
      on E: Exception do
      begin
        SetTexto(E.ClassName + ': ' + E.Message);
      end;
    End;
  Finally

  End;
end;

end.
