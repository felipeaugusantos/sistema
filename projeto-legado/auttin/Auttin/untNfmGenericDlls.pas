unit untNfmGenericDlls;

interface

uses
  untFuncoesSimples, untGerenciadorMenuAuttinDlls, untAuttinWrapper,
   SysUtils, Forms, Dialogs, Windows, UniClientDataSet, Variants, dxCore,
   Uni, DB, Vcl.Themes, Vcl.Styles, Vcl.SysStyles, Classes, System.StrUtils,
   untFuncoesDllAutTin, untFuncTinta;

procedure CriarNovasFormulasDllGeneric(AClass: String); Stdcall;
function fVerificaAcesso(strHint: String): Boolean; Stdcall;

implementation

procedure CriarNovasFormulasDllGeneric(AClass: String); Stdcall;
const
  // Overrides: middle (após "mnuCad", antes de "NovasFormulas") > IDEPRO real
  // Apenas para tintas com nome divergente do padrão
  arrOverrides: array[0..2, 0..1] of String = (
    ('Mix',     'LAZ'),     // mnuCadMixNovasFormulas      > Lazzumix
    ('PpgNexa', 'PPX'),     // mnuCadPpgNexaNovasFormulas  > PPG/Nexa
    ('StaWeb',  'STW')      // mnuCadStaWebNovasFormulas   > Starmix Web
  );
var
  stlIdentificadores: TStringList;
  intIdx: Integer;
  strMsgErr,
  strIdePro: String;
begin
  strMsgErr := 'A DLL da tinta específica não foi encontrada ou usuário não possui direito de acesso!' + #13#10 +
               'Favor entrar em contato com a CITEL.' + #13#10 + 'Obrigado.';

  if not Assigned(TGerenciadorMenuAuttinDlls.Get(AClass)) then
  begin
    if not Assigned(processaMenu) then
    begin
      pMensagemSonora(strMsgErr);
      Exit;
    end;

    // 1. Extrai o "meio" do AClass.
    //    AClass = 'mnuCad' + <meio> + 'NovasFormulas'
    //    Ex: 'mnuCadSuvNovasFormulas'      strMeio = 'Suv'
    //        'mnuCadPpgNexaNovasFormulas'  strMeio = 'PpgNexa'
    //        'mnuCadStaWebNovasFormulas'   strMeio = 'StaWeb'
    strIdePro := AnsiUpperCase(AClass);
    strIdePro := ReplaceText(strIdePro, 'mnuCad', '');
    strIdePro := ReplaceText(strIdePro, 'NovasFormulas', '');

    // 2. Aplica override se existir; senão usa os 3 primeiros chars upper.
    for intIdx := Low(arrOverrides) to High(arrOverrides) do
    begin
      if SameText(strIdePro, arrOverrides[intIdx, 0]) then
      begin
        strIdePro := arrOverrides[intIdx, 1];
        Break;
      end;
    end;

    if Length(strIdePro) > 3 then
      strIdePro := Copy(strIdePro, 1, 3);

    stlIdentificadores := TStringList.Create;
    try
      GetLibTintaFactory.GetIdentificadores(stlIdentificadores);

      // 3. Tentativa direta: só carrega a DLL do IDEPRO derivado/mapeado.
      for intIdx := 0 to stlIdentificadores.Count - 1 do
      begin
        if not SameText(strIdePro, stlIdentificadores[intIdx]) then
          Continue;

        processaMenu.ProcessarMenuTintaEspecifica(mnuTinta, stlTinta, stlIdentificadores[intIdx]);
        Break;
      end;

      // 4. Fallback: se mesmo assim o gerenciador não foi registrado, cai no loop completo (cobre divergências futuras não mapeadas).
      if not Assigned(TGerenciadorMenuAuttinDlls.Get(AClass)) then
      begin
        for intIdx := 0 to stlIdentificadores.Count - 1 do
        begin
          // Pula a tinta que já tentamos no passo 3
          if SameText(strIdePro, stlIdentificadores[intIdx]) then
            Continue;

          processaMenu.ProcessarMenuTintaEspecifica(mnuTinta, stlTinta, stlIdentificadores[intIdx]);
          if Assigned(TGerenciadorMenuAuttinDlls.Get(AClass)) then
            Break;
        end;
      end;
    finally
      FreeAndNil(stlIdentificadores);
    end;
  end;

  if not Assigned(TGerenciadorMenuAuttinDlls.Get(AClass)) then
  begin
    pMensagemSonora(strMsgErr);
    Exit;
  end;

  TGerenciadorMenuAuttinDlls.Get(AClass).Executar(TAuttinWrapper.Create());
end;

function fVerificaAcesso(strHint: String): Boolean; Stdcall;
Var
  strSQL: String;
  qryGen: TUniQuery;
Begin
  If VS_strUsaTmq = 'N' Then
    Exit(False);

  If fEhAdministrador(strLoginUsuarioLogado) Then
    Exit(True);

  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT "DIRTIN"     AS TIP_ACESSO, ';
    strSQL := strSQL + '        TIN_NOMFRM   AS DIR_NOMFRM  ';
    strSQL := strSQL + '   FROM DIRTIN ';
    strSQL := strSQL + '  WHERE TIN_CODOPE = :CODOPE        ';
    strSQL := strSQL + '  AND TIN_NOMFRM = :NOMFRM          ';

    strSQL := strSQL + ' UNION ALL ';

    strSQL := strSQL + ' SELECT "DIRGPT"     AS TIP_ACESSO, ';
    strSQL := strSQL + '        D.DIR_NOMFRM AS DIR_NOMFRM  ';
    strSQL := strSQL + '   FROM DIRGPT D ';
    strSQL := strSQL + '        JOIN CADGPO G ON G.GPO_CODGPO = D.GPT_CODGPO ';
    strSQL := strSQL + '        JOIN OPEGPO O ON O.GPO_CODGPO = G.GPO_CODGPO ';
    strSQL := strSQL + ' WHERE O.OPE_CODOPE = :CODOPE       ';
    strSQL := strSQL + '   AND DIR_NOMFRM = :NOMFRM         ';

    qryGen := fCriaQuery(Nil);
    qryGen.Close;
    qryGen.SQL.Text := strSQL;
    qryGen.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
    qryGen.ParamByName('NOMFRM').AsString := strHint;
    qryGen.Open;

    Result := Not qryGen.IsEmpty;
  Finally
    FreeAndNil(qryGen);
  End;
End;

end.
