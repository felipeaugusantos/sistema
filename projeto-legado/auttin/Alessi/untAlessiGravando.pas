unit untAlessiGravando;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untAbstractGravando, AppEvnts, Menus, StdCtrls, CheckLst, Buttons, ExtCtrls, Gauges,
  ActiveX,  BitBtnLockedIncrem, ActnList, System.Actions;

type
  TfrmAlessiGravando = class(TfrmAbstractGravando)
    procedure btnConfirmaGeracaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAlessiGravando: TfrmAlessiGravando;

implementation

uses
  untAlessiGravandoCores, untAlessiGravandoColorantes,
  untFuncoesSimples, untStatusGravando, untAlessiGravandoBases;

{$R *.dfm}

procedure TfrmAlessiGravando.btnConfirmaGeracaoClick(Sender: TObject);
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
            0: gravandoExecucao := TAlessiGravandoBases.Create();
            1: gravandoExecucao := TAlessiGravandoColorantes.Create();
            2: gravandoExecucao := TAlessiGravandoCores.Create();
          end;
        end;

        if Assigned(gravandoExecucao) then
        begin
          CoInitialize(nil);
          status := sgGravando;
          SetTexto(chklstOpcoes.Items[intIndex] + ' iniciado ');
          gravandoExecucao.Executar(Self);
          if status <> sgCancelado then
          begin
            status := sgFinalizado;
            SetTexto(chklstOpcoes.Items[intIndex] + ' finalizado ');
          end;
          gravandoExecucao := nil;
          CoUnInitialize;

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
