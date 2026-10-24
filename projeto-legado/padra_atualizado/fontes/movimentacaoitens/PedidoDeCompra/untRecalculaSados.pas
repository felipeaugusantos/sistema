unit untRecalculaSados;

interface

Uses
  cxProgressBar, UniClientDataSet,
  SysUtils,
  Classes;

Type
  TRecSadoReservado = Class(TObject)

    Function fAtualizaSalRes(pgbProgresso: TcxProgressBar): Boolean;
  Public
    cdsItens,
    cdsItensSintetico: TUniClientDataSet;

    blnEmbala: Boolean;

    constructor Create; Reintroduce;
    Procedure pAtualizaReservados(blnConvEmbalagem: Boolean);
  End;

implementation

Uses
  untFuncoesSimples, untGravando;

constructor TRecSadoReservado.Create;
Begin
  Inherited Create;

  blnEmbala         := False;
  cdsItens          := Nil;
  cdsItensSintetico := Nil;
End;

Function TRecSadoReservado.fAtualizaSalRes(pgbProgresso: TcxProgressBar): Boolean;
Begin
  Result := fAtualizaSaldoReservado(cdsItens, cdsItensSintetico, pgbProgresso, blnEmbala);
End;

Procedure TRecSadoReservado.pAtualizaReservados(blnConvEmbalagem: Boolean);
Begin

  Try
    blnEmbala := blnConvEmbalagem;

    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.lblGravando.Caption := 'Convertendo embalagens...';
    frmGravando.fExecutarAcao := fAtualizaSalRes;
    frmGravando.ShowModal;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TRecSadoReservado.pAtualizaReservados]');
    End;
  End;

  pFreeAndNil(frmGravando);
End;

end.
