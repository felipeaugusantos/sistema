{*************************************************************************}
{* Classe responsável pela geração do cadastro de Formulas da tinta Resicolor *}
{**********************************************************************PH*}
unit untGravandoExecucaoResicolorFormulas;

interface

uses
  untAbstractGravandoExecucaoResicolor, untIGravando, SysUtils, untIDataSet,
  untAutcomTintaFactory, untStrUtils, untStatusGravando, DB, StrUtils, ComObj,
  Variants, Math, ADODB, Classes;

type
  TGravandoExecucaoResicolorFormulas = class(TAbstractGravandoExecucaoResicolor)
  public
    function fGetNomeGravacao: string; override;
    procedure Executar(const gravando: IGravando); override;

  end;

Implementation

uses
  untFuncoesGenerica;

{ TGravandoExecucaoResicolorFormulas }

procedure TGravandoExecucaoResicolorFormulas.Executar(const gravando: IGravando);
Var
  intProducts : Integer;
  intSubProds : Integer;

  strPatPro   : String;
  strPatSub   : String;
  strSubKey   : String;
begin
  Try
    Try
      Gravando.Texto := 'Verificando path do arquivo...';

      If Not DirectoryExists(GetPathPro) Then
      Begin
        Gravando.Texto := Format('O diretorio %s não existe!', [AnsiReplaceStr(GetPathPro, '"', '')]);
        Exit;
      End;

      Gravando.Texto := 'Path verificado com sucesso...';
      Gravando.Texto := 'Processando arquivos do Cadastro de Fórmulas...';

      For intProducts := 1 To 1 Do
      Begin
        strPatPro := GetPathPro;

        Gravando.Texto := Format('Processando Produto: [%s]',[AnsiReplaceStr(strPatPro, '"', '')]);

        pCarregarSubProdutos(strPatPro);

        For intSubProds := 1 To tblSubProds.RecordCount Do
        Begin

          If (Gravando.Status <> sgGravando) Then
            Break;

          strPatSub := strPatPro + '\' + tblSubProds.FieldByName('PATH').AsString;
          strSubKey := TStrUtils.fStrZero(Trim(tblSubProds.FieldByName('ID').AsString), 2);

          pCriaArquivoText(strPatPro);

          pCarregarFrm(strPatPro, strPatSub, Gravando);
          Gravando.RegistrarProgresso(0, intSubProds, tblSubProds.RecordCount);
          tblSubProds.Next;
        End;
        Gravando.RegistrarProgresso(0, 1, 1);
      End;
    Except
      On E: Exception Do
      Begin
        Gravando.Texto := Format('%s: %s', [E.ClassName, E.Message]);
        Exit;
      End;
    End;
  Finally
    Gravando.Texto := 'Cadastro de Fórmulas processado com sucesso...';
  End;
end;

function TGravandoExecucaoResicolorFormulas.fGetNomeGravacao: string;
begin
  Result := 'Cadastro de Formulas';
end;


end.
