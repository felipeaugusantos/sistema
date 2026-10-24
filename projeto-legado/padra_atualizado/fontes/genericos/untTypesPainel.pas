unit untTypesPainel;

interface

Uses IniFiles, Forms, SysUtils;

Type

  TTipo = Record
    intCodigo : Integer;
    strDescri : String;
  End;

  Var
    arrStatusPed : Array [0..11] of TTipo;
    arrFormaPgto : Array [0..2] of TTipo;

  Function fTraduzCodigo(arrTipo : Array Of TTipo; intCodigo : Integer) : String;
  Function fTraduzDescricao(arrTipo : Array Of TTipo; strDescri : String) : Integer;
  Procedure pMontaFormas;
  Procedure pMontaStatus;

implementation

Function fTraduzCodigo(arrTipo : Array Of TTipo; intCodigo : Integer) : String;
  Var
    intIndex : Integer;
Begin
  Result := '';
  For intIndex := Low(arrTipo) To High(arrTipo) Do
  Begin
    If arrTipo[intIndex].intCodigo = intCodigo Then
    Begin
      Result := arrTipo[intIndex].strDescri;
      Break;
    End;
  End;

End;

Function fTraduzDescricao(arrTipo : Array Of TTipo; strDescri : String) : Integer;
  Var
    intIndex : Integer;
Begin
  Result := -1;
  For intIndex := Low(arrTipo) To High(arrTipo) Do
  Begin
    If arrTipo[intIndex].strDescri = strDescri Then
    Begin
      Result := arrTipo[intIndex].intCodigo;
      Break;
    End;
  End;

End;

Procedure pMontaFormas;
  Var
    iniArqIni : TIniFile;
begin
  iniArqIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'opcoes.ini');
  Try

    arrFormaPgto[0].intCodigo := StrToIntDef(iniArqIni.ReadString('MONITOR','CODCAR','-1'),-1);
    arrFormaPgto[0].strDescri := 'Cartão de Crédito';

    arrFormaPgto[1].intCodigo := StrToIntDef(iniArqIni.ReadString('MONITOR','CODBOL','-1'),-1);
    arrFormaPgto[1].strDescri := 'Boleto';

    arrFormaPgto[2].intCodigo := StrToIntDef(iniArqIni.ReadString('MONITOR','CODONL','-1'),-1);
    arrFormaPgto[2].strDescri := 'Transferência On-Line';

  Finally
	  iniArqIni.Free;
  End;

end;

Procedure pMontaStatus;
  Var
    iniArqIni : TIniFile;
begin
  arrStatusPed[0].intCodigo := 1   ;
  arrStatusPed[0].strDescri:= 'Efetuado';

  arrStatusPed[1].intCodigo := 4   ;
  arrStatusPed[1].strDescri:= 'Problemas';

  arrStatusPed[2].intCodigo := 5   ;
  arrStatusPed[2].strDescri:= 'Cancelado';

  arrStatusPed[3].intCodigo := 6   ;
  arrStatusPed[3].strDescri:= 'Aguardando Pagamento';

  arrStatusPed[4].intCodigo := 7   ;
  arrStatusPed[4].strDescri:= 'Pagamento Confirmado';

  arrStatusPed[5].intCodigo := 8   ;
  arrStatusPed[5].strDescri:= 'Analise Risco';

  arrStatusPed[6].intCodigo := 17  ;
  arrStatusPed[6].strDescri:= 'Despachado';

  arrStatusPed[7].intCodigo := 92  ;
  arrStatusPed[7].strDescri:= 'Entregue';

  arrStatusPed[8].intCodigo := 99  ;
  arrStatusPed[8].strDescri:= 'Troca';

  arrStatusPed[9].intCodigo := 100 ;
  arrStatusPed[9].strDescri:= 'Cupom Prox. Compra';

  arrStatusPed[10].intCodigo := 108 ;
  arrStatusPed[10].strDescri:= 'Alterar Forma Pgto';

  iniArqIni := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'opcoes.ini');
  Try
    arrStatusPed[11].intCodigo :=  StrToIntDef(iniArqIni.ReadString('MONITOR','FATURA','-1'),-1);;
    arrStatusPed[11].strDescri:= 'Faturado';
  Finally
    iniArqIni.Free;
  End;
End;

Initialization
  pMontaFormas;
  pMontaStatus;


end.
