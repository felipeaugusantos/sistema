unit untTAntecipacao;

interface

Uses
  untFuncoesSimples,SysUtils, WIndows;

  procedure pAnteciparCartoes(ANomCon:String; AAplicacao: HWND) StdCall;
  procedure pRedeCard(AAplicacao: HWND);

implementation

Uses
  untAntecipacaoRedeCard;

procedure pAnteciparCartoes(ANomCon:String; AAplicacao: HWND);
Begin
  If UpperCase(ANomCon).Equals('REDECARD') Then
    pRedeCard(AAplicacao);
End;

procedure pRedeCard(AAplicacao: HWND);
  Var
    LAntecipacaoRedeCard : TfrmAntecipacaoRedeCard;
Begin
  Try
    pCriarFormularios(TfrmAntecipacaoRedeCard,LAntecipacaoRedeCard);
    LAntecipacaoRedeCard.Aplicacao := AAplicacao;
    LAntecipacaoRedeCard.ShowModal;
  Finally
    FreeAndNil(LAntecipacaoRedeCard);
  End;
End;

end.
