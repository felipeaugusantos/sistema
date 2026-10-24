unit untEndPartidaConsFrete;

interface

uses
  Vcl.Controls;

type
  TRecEnderecoPartida = Record
    strAutoincrem: String;
    strDescricao: String;
    strCep: String;
    strEndereco: String;
    strBairro: String;
    strCidade: String;
  End;

  function fSelecionaEnderecoPartida(out recEnderecoPartida: TRecEnderecoPartida): Boolean;

implementation

uses
  untFuncoesSimples, untSelecEndPartidaConsFrete;

function fSelecionaEnderecoPartida(out recEnderecoPartida: TRecEnderecoPartida): Boolean;
  Var
    frmSelecEndPartidaConsFrete: TfrmSelecEndPartidaConsFrete;
begin
  pCriarFormularios(TfrmSelecEndPartidaConsFrete, frmSelecEndPartidaConsFrete);

  Try
    FillChar(recEnderecoPartida, SizeOf(recEnderecoPartida), #0);

    frmSelecEndPartidaConsFrete.ShowModal;

    Result := (frmSelecEndPartidaConsFrete.ModalResult = mrOk);

    If Not Result Then
      Exit;

    recEnderecoPartida.strAutoincrem := frmSelecEndPartidaConsFrete.qryEndere.FieldByName('AUTOINCREM').AsString;
    recEnderecoPartida.strDescricao  := frmSelecEndPartidaConsFrete.qryEndere.FieldByName('END_DESCRI').AsString;
    recEnderecoPartida.strCep        := frmSelecEndPartidaConsFrete.qryEndere.FieldByName('END_C_E_P_').AsString;
    recEnderecoPartida.strEndereco   := frmSelecEndPartidaConsFrete.qryEndere.FieldByName('END_ENDERE').AsString;
    recEnderecoPartida.strBairro     := frmSelecEndPartidaConsFrete.qryEndere.FieldByName('END_BAIRRO').AsString;
    recEnderecoPartida.strCidade     := frmSelecEndPartidaConsFrete.qryEndere.FieldByName('END_NOMCID').AsString;
  Finally
    pFreeAndNil(frmSelecEndPartidaConsFrete);
  End;
end;

end.
