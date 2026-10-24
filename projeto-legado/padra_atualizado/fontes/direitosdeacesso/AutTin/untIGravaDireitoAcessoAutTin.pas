unit untIGravaDireitoAcessoAutTin;

interface

uses
  Classes, DB, StdCtrls, untTypesSistema;

type
  IGravaDireitoAcessoAutTin = interface
    procedure SetPesqOperador(AEdit: TEdit);
    procedure SetPesqGrupo(AEdit: TEdit);

    function TemPesquisa(): Boolean;

    function getCdsOpe: TDataSet;
    function getCdsGpo: TDataSet;

    function getMarcarOpe: Boolean;
    function getMarcarGpo: Boolean;

    function fTemRegistroSelecionado: Boolean;

    procedure pMarcaDesmarcaOperador(blnMarcar: Boolean);
    procedure pMarcaDesmarcaGrupo(blnMarcar: Boolean);

    procedure pMarcaDesmarcaTotalOperador(blnMarcar: Boolean);
    procedure pMarcaDesmarcaTotalGrupo(blnMarcar: Boolean);

    function  fGravar: Boolean;

    function fVerificaSeExisteDireitoDeAcessoVinculadoAoOperador(strCodOpe: String): Boolean;
    function fVerificaSeExisteDireitoDeAcessoVinculadoAoGrupo(strCodGpo: String): Boolean;

    function getTipoOperacao: TTipDir;
  end;

implementation

end.
