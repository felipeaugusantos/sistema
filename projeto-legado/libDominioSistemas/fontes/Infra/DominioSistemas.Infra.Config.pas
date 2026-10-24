unit DominioSistemas.Infra.Config;

interface

const
  IDENTIFICADOR_API_DOMINIO = 'INT_DOMINIO' ;
  ID_LOCK_LCKATC = 'ROBO_INTEGRACAO_DOMINIO';
  ATTEMPTSLOCKCITEL = 10;

  {$IFDEF LINUX}
    DDL_POST = 'libGenericRestPost.so' ;
  {$ELSE}
    DDL_POST = 'GenericRestPost.dll' ;
  {$ENDIF}

implementation

end.
