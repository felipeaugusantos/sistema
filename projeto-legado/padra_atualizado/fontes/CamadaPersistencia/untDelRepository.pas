{******************************************}
{* REPOSITORY DDE GRAVAÇÃO DOS ARQUIVOS   *}
{* DELETADOS DEL_XXXXXX QUE TEM INTERAÇÃO *}
{* COM A CAMADA DE PERSISTÊNCIA           *}
{*17/06/2015****************************AF*}
unit untDelRepository;

interface

uses untObjectManager, Aurelius.Mapping.Metadata, System.SysUtils;

Type
  TGravaDel = class
  Public
    class procedure pGrava(obj: TObject; frwk: TObjManager);
  End;

implementation

{ TGravaDel }

uses untFuncoesSimples;

{**********************************************}
{* GRAVA DEL_XXX. O OBJETO PASSADO DEVE SER   *}
{* UM OBJETO REFERENTE A TABELA DEL E O MESMO *}
{* JÁ DEVE ESTAR CRIADO E CARREGADO.          *}
{* OBS: UTILIZAR PCLONE PARA COPIAR DADOS     *}
{*******************************************AF*}
class procedure TGravaDel.pGrava(obj: TObject; frwk: TObjManager);
  Var
    Column: TColumn;
Begin
  Try
    Column := frwk.objDBManager.Explorer.GetColumnByName(obj.ClassType, 'OPEDEL');
    frwk.objDBManager.Explorer.SetColumnDbValue(obj, Column, strLoginUsuarioLogado);

    Column := frwk.objDBManager.Explorer.GetColumnByName(obj.ClassType, 'DTADEL');
    frwk.objDBManager.Explorer.SetColumnDbValue(obj, Column, VS_Date);

    Column := frwk.objDBManager.Explorer.GetColumnByName(obj.ClassType, 'HORDEL');
    frwk.objDBManager.Explorer.SetColumnDbValue(obj, Column, Time);

    frwk.objDBManager.Save(obj);
  Except
    On E: Exception Do
      Raise Exception.Create('[TGravaDel.pGrava] - Ocorreu um erro ao excluir o registro.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
end;

end.
