{**************************************************************************************}
{* Classe responsável pela geração do cadastro de colorantes da tinta SherwinWilliams *}
{***********************************************************************************AC*}
unit untGravandoExecucaoSherwinWilliamsColorantes;

interface

uses
  untAbstractGravandoExecucaoSherwinWilliams, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStatusGravando, ComObj, Dialogs, StrUtils, untStrUtils,
  DB, UniClientDataSet;
type
  TGravandoExecucaoSherwinWilliamsColorantes = class(TAbstractGravandoExecucaoSherwinWilliams)
  private
    procedure pGravaCadCol(arrColShe : Array of TColShe);
    procedure pImportaColorantes;
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;
  end;

implementation

{ TGravandoExecucaoSherwinWilliamsCores }

procedure TGravandoExecucaoSherwinWilliamsColorantes.Executar(const gravando: IGravando);
var
  intProducts : Integer;
  intSubProds : Integer;
  intFrm      : Integer;
  intMask     : Integer;
  intPos      : Integer;
  strProKey   : String;
  strPatPro   : String;
  strPatSub   : String;
  strSubKey   : String;
  strFormula  : String;
  arrColShe   : Array Of TColShe;
  strPatDbf   : String;
begin
  Try
    Try
      gravando.Texto := 'Validando Path de Arquivos ...';

      If (Not fValidaPath) Then
      Begin
        gravando.Texto := 'Path para a geração do arquivo de colorantes não é válido...';
        gravando.Cancelar;
        Exit;
      End;

      gravando.Texto := 'Path validado com sucesso ...';
{
      If Not fVerificaCadEmb Then
      Begin
        If qrySHE_CADEMB.IsEmpty Then
        Begin
          If TAutcomTintaFactory.Get.fMensagem('', 'O Cadastro de Embalagem está inconsistente!' + #13#10 + 'Deseja importar o cadastro?', ['&Sim', '&Não']) = 1 Then
            pImportarCadEmb(gravando);
        End
        Else
          gravando.Texto := 'O Cadastro de Embalagem está inconsistente!';

        gravando.Cancelar;
        Exit;
      End;
}
      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Verificando PROCOD...';
      TAutcomTintaFactory.Get.fInsereProCod('SHE_CADCOL');
      gravando.Texto := 'PROCOD verificado com sucesso!';

      if gravando.Status <> sgGravando then
        Exit;

      gravando.Texto := 'Iniciando Geração do Cadastro de Colorantes ...';

      strPatDbf := GetPath;

      pImportaColorantes;

      Try
        Try
          if gravando.Status <> sgGravando then
            Exit;

          For intProducts := 1 To tblProducts.RecordCount Do
          Begin
            if gravando.Status <> sgGravando then
              Exit;

            strPatPro := strPatDbf + '\' + tblProducts.FieldByName('PATH').AsString;
            strProKey := TStrUtils.fStrZero(Trim(tblProducts.FieldByName('ID').AsString), 2);
            pCarregarSubprods(strPatPro);

            If tblSubprods.Active Then
            Begin
              For intSubProds := 1 To tblSubprods.RecordCount Do
              Begin
                if gravando.Status <> sgGravando then
                  Exit;

                strPatSub := strPatPro + '\' + tblSubprods.FieldByName('PATH').AsString;
                strSubKey := TStrUtils.fStrZero(Trim(tblSubprods.FieldByName('ID').AsString), 2);
                pCarregarFrm(strPatPro, strPatSub, gravando);
                pCarregarMask(strPatSub);

                For intFrm := 1 To tblFrm.RecordCount Do
                Begin
                  if gravando.Status <> sgGravando then
                    Exit;

                  tblMask.First;

                  For intMask := 1 To tblMask.RecordCount Do
                  Begin
                    strFormula := tblFrm.FieldByName('FORMULA').AsString;
                    SetLength(arrColShe, 0);

                    While (Not TStrUtils.fEmptyStr(strFormula)) Do
                    Begin
                      SetLength(arrColShe, Length(arrColShe) + 1);
                      intPos := Pos(',', strFormula);
                      arrColShe[Length(arrColShe) - 1].strCodCol := TStrUtils.fStrZero(Copy(strFormula, 1, intPos - 1), 2);
                      arrColShe[Length(arrColShe) - 1].strDesCol := fRetDesCol(Copy(strFormula, 1, intPos - 1));
                      strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
                      intPos := Pos(',', strFormula);
                      If intPos <= 0 Then
                        intPos := Length(strFormula)+1;
                      arrColShe[Length(arrColShe) - 1].fltQtdCol := TAutcomTintaFactory.Get.fStrToFloat(AnsiReplaceStr(Copy(strFormula, 1, intPos - 1), '.', ','));

                      {*******************************************}
                      {* FORMULA GEL TEM QUE MULTIPLICAR POR 0.2 *}
                      {****************************************PH*}
                      If (tblProducts.FieldByName('PATH').AsString = 'PROD0005')
                        And (tblSubprods.FieldByName('PATH').AsString = 'SUBP0001') Then
                      Begin
                        arrColShe[Length(arrColShe) - 1].fltQtdCol := arrColShe[Length(arrColShe) - 1].fltQtdCol * 0.2;
                      End;

                      strFormula := Copy(strFormula, intPos + 1, Length(strFormula));
                    End;

                    if gravando.Status <> sgGravando then
                      Exit;

                    SetLength(arrColShe, 20);

                    If (tblMask.FieldByName('TYPE').AsString = 'CA') Then
                    Begin
                      pGravaCadCol(arrColShe);
                    End;

                    tblMask.Next;
                  End;
                  gravando.RegistrarProgresso(0, tblFrm.RecNo, tblFrm.RecordCount);

                  tblFrm.Next;
                End;
                tblSubprods.Next;
              End;
            End;
            tblProducts.Next;
          End;
        Except
          on E: Exception do
          begin
            gravando.Cancelar;
            gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
          End;
        End;
      Finally
        gravando.Texto := 'Finalizado o processo de gravação do arquivo...';
      End;
    Except
      on E: Exception do
      begin
        gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
      end;
    End;
  Finally
    If Assigned(cdsCol) Then FreeAndNil(cdsCol);
  End;
end;

function TGravandoExecucaoSherwinWilliamsColorantes.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Colorantes';
end;

procedure TGravandoExecucaoSherwinWilliamsColorantes.pGravaCadCol(
  arrColShe: array of TColShe);
  Var
    intCont : Integer;
begin
  For intCont := Low(arrColShe) To High(arrColShe) Do
  Begin
    If Not qrySHE_CADCOL.Locate('COL_CODCOL', arrColShe[intCont].strCodCol, []) and
       Not TStrUtils.fEmptyStr(arrColShe[intCont].strCodCol) Then
    Begin
      If TStrUtils.fEmptyStr(arrColShe[intCont].strCodCol) Then
        Break;

      qrySHE_CADCOL.Insert;
      qrySHE_CADCOL.FieldByName('COL_CODCOL').AsString := arrColShe[intCont].strCodCol;
      qrySHE_CADCOL.FieldByName('COL_CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
      qrySHE_CADCOL.FieldByName('AUTOINCREM').AsString := TAutcomTintaFactory.Get.fRetAutoIncrem('SHE_CADCOL', TAutcomTintaFactory.Get.GetCodEmp);
      qrySHE_CADCOL.FieldByName('COL_DESCRI').AsString := arrColShe[intCont].strDesCol;
      qrySHE_CADCOL.FieldByName('COL_EMBALA').AsFloat  := 946;
      qrySHE_CADCOL.Post;
    End
  End;
end;

procedure TGravandoExecucaoSherwinWilliamsColorantes.pImportaColorantes;
begin

  cdsCol := TUniClientDataSet.Create(Nil);

  With cdsCol.FieldDefs.AddFieldDef Do
  Begin
    DataType := ftString;
    Name     := 'ID';
    Size     := 5;
  End;

  With cdsCol.FieldDefs.AddFieldDef Do
  Begin
    DataType := ftString;
    Name     := 'DESCR';
    Size     := 100;
  End;

  cdsCol.CreateDataSet;

  tblCnts.First;
  While Not tblCnts.Eof Do
  Begin
    cdsCol.Append;
    cdsCol.FieldByName('ID').AsString    := Trim(tblCnts.FieldByName('ID').AsString);
    cdsCol.FieldByName('DESCR').AsString := Trim(tblCnts.FieldByName('DESCR').AsString);
    cdsCol.Post;

    tblCnts.Next;
  End;
end;

end.


